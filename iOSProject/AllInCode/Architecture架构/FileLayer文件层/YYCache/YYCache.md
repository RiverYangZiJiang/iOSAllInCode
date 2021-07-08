#  YYCache

支持缓存到内存和磁盘，性能优越。能够缓存小数据，也能够缓存对象、图片属性、文件

## 特性

- **LRU**: 缓存支持 LRU (least-recently-used) 淘汰算法。

- **缓存控制**: 支持多种缓存控制方法：总数量、总大小、存活时间、空闲空间。

- **兼容性**: API 基本和 `NSCache` 保持一致, 所有方法都是线程安全的。

- 内存缓存

  - **对象释放控制**: 对象的释放(release) 可以配置为同步或异步进行，可以配置在主线程或后台线程进行。
  - **自动清空**: 当收到内存警告或 App 进入后台时，缓存可以配置为自动清空。

- 磁盘缓存

  - **可定制性**: 磁盘缓存支持自定义的归档解档方法，以支持那些没有实现 NSCoding 协议的对象。
  - **存储类型控制**: 磁盘缓存支持对每个对象的存储类型 (SQLite/文件) 进行自动或手动控制，以获得更高的存取性能。

  

  

  

  ## NSCache、YYMemoryCache优缺点

  | 内存缓存方案  | 优点                                    | 缺点                                                         |                                                              |
  | ------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
  | NSDictionary  |                                         | 线程不安全                                                   |                                                              |
  | NSCache       | 线程安全，写入性能稍差，读取性能不错    | 性能和 key 的相似度有关，如果有大量相似的 key (比如 “1”, “2”, “3”, …)，NSCache 的存取性能会下降得非常厉害，大量的时间被消耗在 CFStringEqual() 上 | 和 NSDictionary 类似的 API，且不会 retain key，底层调用了libcache.dylib中线程安全由 pthread_mutex 完成 |
  | YYMemoryCache | 性能好，仅次于NSDictionary + OSSpinLock |                                                              |                                                              |

  

## 有哪四种磁盘缓存方案？实现-优缺点分别是？

| 磁盘缓存方案         | 实现                                                         | 优点                                                         | 缺点                                                         | 库                               |
| -------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------------- |
| 基于文件系统         | 即一个 Value 对应一个文件，通过文件读写来缓存数据            |                                                              | 不方便扩展、没有元数据、难以实现较好的淘汰算法、数据统计缓慢。 | SDWebImage                       |
| 基于mmap文件内存映射 |                                                              | 性能好                                                       | 热数据的文件不要超过物理内存大小，不然 mmap 会导致内存交换严重降低性能；另外内存中的数据是定时 flush 到文件的，如果数据还未同步时程序挂掉，就会导致数据错误。 | FastImageCache                   |
| 基于sqlite数据库     |                                                              | 支持元数据、扩展方便、数据统计速度快，也很容易实现 LRU 或其他淘汰算法 | <u>SQLite 写入性能比直接写文件要高，但读取性能取决于数据大小：当单条数据小于 20K 时，数据越小 SQLite 读取性能越高；单条数据大于 20K 时，直接写为文件速度会更快一些</u>。这和 [SQLite 官网的描述](http://www.sqlite.org/intern-v-extern-blob.html)基本一致。 |                                  |
| 混合式               | key-value 元数据保存在 SQLite 中，而 value 数据则根据大小不同选择 SQLite 或文件存储。 | NSURLCache 选定的数据大小的阈值是 16K；FBDiskCache 则把所有 value 数据都保存成了文件。 |                                                              | NSURLCache、FBDiskCache、YYCache |

## 内存/磁盘缓存分别使用什么锁？为什么？

| 锁                          | 锁类型                       | 使用场景                                                     |
| --------------------------- | ---------------------------- | ------------------------------------------------------------ |
| OSSpinLock                  | 自旋锁就是一直 do while 忙等 | 内存缓存：性能最高的锁，缺点是当等待时会消耗大量 CPU 资源，所以它不适用于较长时间的任务。 |
| dispatch_semaphore 是信号量 | 非自旋锁                     | 磁盘缓存：等待时不会消耗 CPU 资源。当信号总量设为 1 时也可以当作锁来。在没有等待情况出现时，它的性能比 pthread_mutex 还要高，但一旦有等待情况出现时，性能就会下降许多。相 |





# YYCache 设计思路

iOS 开发中总会用到各种缓存，最初我是用的一些开源的缓存库，但到总觉得缺少某些功能，或某些 API 设计的不够好用。

## 内存缓存

通常一个缓存是由内存缓存和磁盘缓存组成，内存缓存提供容量小但高速的存取功能，磁盘缓存提供大容量但低速的持久化存储。

NSCache 是苹果提供的一个简单的内存缓存，它有着和 NSDictionary 类似的 API，不同点是它是线程安全的，并且不会 retain key。我在测试时发现了它的几个特点：NSCache 底层并没有用 NSDictionary 等已有的类，而是直接调用了 libcache.dylib，其中线程安全是由 pthread_mutex 完成的。另外，它的性能和 key 的相似度有关，如果有大量相似的 key (比如 “1”, “2”, “3”, …)，NSCache 的存取性能会下降得非常厉害，大量的时间被消耗在 CFStringEqual() 上，不知这是不是 NSCache 本身设计的缺陷。

可以看到 YYMemoryCache 的性能不错，仅次于 NSDictionary + OSSpinLock；
NSCache 的写入性能稍差，读取性能不错；
PINMemoryCache 的读写性能也还可以，但读取速度差于 NSCache；
TMMemoryCache 性能太差以至于图上都看不出来了。

## 磁盘缓存

为了设计一个比较好的磁盘缓存，我调查了大量的开源库，包括 TMDiskCache、PINDiskCache、SDWebImage、FastImageCache 等，也调查了一些闭源的实现，包括 NSURLCache、Facebook 的 FBDiskCache 等。他们的实现技术大致分为三类：基于文件读写、基于 mmap 文件内存映射、基于数据库。

TMDiskCache, PINDiskCache, <u>SDWebImage 等缓存，都是基于文件系统的，即一个 Value 对应一个文件，通过文件读写来缓存数据。</u>他们的实现都比较简单，性能也都相近，缺点也是同样的：不方便扩展、没有元数据、难以实现较好的淘汰算法、数据统计缓慢。

FastImageCache 采用的是 mmap 将文件映射到内存。用过 MongoDB 的人应该很熟悉 mmap 的缺陷：热数据的文件不要超过物理内存大小，不然 mmap 会导致内存交换严重降低性能；另外内存中的数据是定时 flush 到文件的，如果数据还未同步时程序挂掉，就会导致数据错误。抛开这些缺陷来说，mmap 性能非常高。

NSURLCache、FBDiskCache 都是基于 SQLite 数据库的。基于数据库的缓存，唯一不确定的就是数据库读写的性能，为此我评测了一下 SQLite 在真机上的表现。iPhone 6 64G 下，<u>SQLite 写入性能比直接写文件要高，但读取性能取决于数据大小：当单条数据小于 20K 时，数据越小 SQLite 读取性能越高；单条数据大于 20K 时，直接写为文件速度会更快一些</u>。这和 [SQLite 官网的描述](http://www.sqlite.org/intern-v-extern-blob.html)基本一致。另外，直接从官网下载最新的 SQLite 源码编译，会比 iOS 系统自带的 sqlite3.dylib 性能要高很多。<u>基于 SQLite 的这种表现，磁盘缓存最好是把 SQLite 和文件存储结合起来：key-value 元数据保存在 SQLite 中，而 value 数据则根据大小不同选择 SQLite 或文件存储。NSURLCache 选定的数据大小的阈值是 16K；FBDiskCache 则把所有 value 数据都保存成了文件。</u>

我的 YYDiskCache 也是采用的 SQLite 配合文件的存储方式，在 iPhone 6 64G 上的性能基准测试结果见下图。在存取小数据 (NSNumber) 时，YYDiskCache 的性能远远高出基于文件存储的库；而较大数据的存取性能则比较接近了。但得益于 SQLite 存储的元数据，YYDiskCache 实现了 LRU 淘汰算法、更快的数据统计，更多的容量控制选项。

[![disk_cache_bench_result](https://blog.ibireme.com/wp-content/uploads/2015/10/disk_cache_bench_result.png)](https://blog.ibireme.com/wp-content/uploads/2015/10/disk_cache_bench_result.png)

## 备注：

**关于锁：**

OSSpinLock 自旋锁，性能最高的锁。原理很简单，就是一直 do while 忙等。它的缺点是当等待时会消耗大量 CPU 资源，所以它不适用于较长时间的任务。对于内存缓存的存取来说，它非常合适。

dispatch_semaphore 是信号量，但当信号总量设为 1 时也可以当作锁来。在没有等待情况出现时，它的性能比 pthread_mutex 还要高，但一旦有等待情况出现时，性能就会下降许多。相对于 OSSpinLock 来说，它的优势在于等待时不会消耗 CPU 资源。对磁盘缓存来说，它比较合适。

**关于 Realm：**

Realm 是一个比较新的数据库，针对移动应用所设计。它的 API 对于开发者来说非常友好，比 SQLite、CoreData 要易用很多，但相对的坑也有不少。我在测试 SQLite 性能时，也尝试对它做了些简单的评测。我从 Realm 官网下载了它提供的 benchmark 项目，更新 SQLite 到官网最新的版本，并启用了 SQLite 的 sqlite3_stmt 缓存。我的评测结果显示 Realm 在写入性能上差于 SQLite，读取小数据时也差 SQLite 不少，读取较大数据时 Realm 有很大的优势。当然这只是我个人的评测，可能并不能反映真实项目中具体的使用情况。我想看看它的实现原理，但发现 Realm 的核心 realm-core 是闭源的（评论里 Realm 员工提到目前有在 Apache 2.0 授权下的开源计划），能知道的是 Realm 应该用 了 mmap 把文件映射到内存，所以才在较大数据读取时获得很高的性能。另外我注意到添加了 Realm 的 App 会在启动时向某几个 IP 发送数据，评论中有 Realm 员工反馈这是发送匿名统计数据，并且只针对模拟器和 Debug 模式。这部分代码目前是开源的，并且可以通过环境变量 REALM_DISABLE_ANALYTICS 来关闭，如果有使用 Realm 的可以注意一下。



# YYCache Class Reference

本类所有初始化方法都最终调用initWithPath:方法，会先创建磁盘缓存，然后文件名后缀创建内存缓存，取数据优先从内存缓存取，没有再到磁盘，然后将磁盘缓存存到内存缓存。如果想只使用内存缓存，则需要调用YYMemoryCache里的new方法，再设置name

磁盘缓存默认在Caches目录，创建name的目录名称

| Inherits from | NSObject  |
| ------------- | --------- |
| Declared in   | YYCache.h |



## Overview

`YYCache` is a thread safe key-value cache.

It use [`YYMemoryCache`](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYMemoryCache.html) to store objects in a small and fast memory cache, and use [`YYDiskCache`](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYDiskCache.html) to persisting objects to a large and slow disk cache. See [`YYMemoryCache`](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYMemoryCache.html) and [`YYDiskCache`](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYDiskCache.html) for more information.

Tasks

### Other Methods

- ` name` property
- ` memoryCache` property
- ` diskCache` property
- `– initWithName:`
- `– initWithPath:`
- `+ cacheWithName:`
- `+ cacheWithPath:`
- `– init`
- `+ new`



### Access Methods

- `– containsObjectForKey:`
- `– containsObjectForKey:withBlock:`
- `– objectForKey:`
- `– objectForKey:withBlock:`
- `– setObject:forKey:`
- `– setObject:forKey:withBlock:`
- `– removeObjectForKey:`
- `– removeObjectForKey:withBlock:`
- `– removeAllObjects`
- `– removeAllObjectsWithBlock:`
- `– removeAllObjectsWithProgressBlock:endBlock:`



## Properties



### diskCache

```
@property (strong, readonly) YYDiskCache *diskCache
```

Discussion

The underlying disk cache. see [`YYDiskCache`](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYDiskCache.html) for more information.



### memoryCache

```
@property (strong, readonly) YYMemoryCache *memoryCache
```

Discussion

The underlying memory cache. see [`YYMemoryCache`](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYMemoryCache.html) for more information.



### name

```
@property (copy, readonly) NSString *name
```

Discussion

The name of the cache, readonly.



## Class Methods



### cacheWithName:

```
+ (nullable instancetype)cacheWithName:(NSString *)*name*
```

Discussion

Convenience Initializers Create a [new](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/new) instance with the specified [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name). Multiple instances with the same [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name) will make the cache unstable.

Parameters

- name

  The [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name) of the cache. It will create a dictionary with the [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name) in the app’s caches dictionary for disk cache磁盘缓存. Once initialized you should not read and write to this directory.

Return Value

A [new](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/new) cache object, or nil if an error occurs.



### cacheWithPath:

```
+ (nullable instancetype)cacheWithPath:(NSString *)*path*
```

Discussion

Convenience Initializers Create a [new](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/new) instance with the specified path. Multiple instances with the same [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name) will make the cache unstable.

Parameters

- path

  Full path of a directory in which the cache will write data. Once initialized you should not read and write to this directory.

Return Value

A [new](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/new) cache object, or nil if an error occurs.



### new

```
+ (instancetype)new
```



## Instance Methods



### containsObjectForKey:

```
- (BOOL)containsObjectForKey:(NSString *)*key*
```

Discussion

Returns a boolean value that indicates whether a given key is in cache. This method may blocks the calling thread until file read finished.

Parameters

- key

  A string identifying the value. If nil, just return NO.

Return Value

Whether the key is in cache.



### containsObjectForKey:withBlock: 

```
- (void)containsObjectForKey:(NSString *)*key* withBlock:(nullable void ( ^ ) ( NSString *key , BOOL contains ))*block*
```

Discussion

Returns a boolean value with the block that indicates whether a given key is in cache. This method returns immediately and invoke the passed block in background queue when the operation finished.

Parameters

- key

  A string identifying the value. If nil, just return NO.

- block

  A block which will be invoked in background queue when finished.



### init

```
- (instancetype)init
只会打印日志让用initWithPath:方法，然后调用[self initWithPath:@""]返回nil
```



### initWithName:

```
- (nullable instancetype)initWithName:(NSString *)*name*
```

Discussion

Create a [new](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/new) instance with the specified [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name). Multiple instances with the same [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name) will make the cache unstable.

Parameters

- name

  The [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name) of the cache. It will create a dictionary with the [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name) in the app’s caches dictionary for disk cache磁盘缓存. Once initialized you should not read and write to this directory.

Return Value

A [new](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/new) cache object, or nil if an error occurs.



### initWithPath: 

```
- (nullable instancetype)initWithPath:(NSString *)*path*
```

Discussion

Create a [new](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/new) instance with the specified path. Multiple instances with the same [name](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/name) will make the cache unstable.

Parameters

- path

  Full path of a directory in which the cache will write data. Once initialized you should not read and write to this directory.

Return Value

A [new](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/new) cache object, or nil if an error occurs.



### objectForKey:

```
- (nullable id<NSCoding>)objectForKey:(NSString *)*key*
```

Discussion

Returns the value associated with a given key. This method may blocks the calling thread until file read finished.

Parameters

- key

  A string identifying the value. If nil, just return nil.

Return Value

The value associated with key, or nil if no value is associated with key.



### objectForKey:withBlock:

```
- (void)objectForKey:(NSString *)*key* withBlock:(nullable void ( ^ ) ( NSString *key , id<NSCoding> object ))*block*
```

Discussion

Returns the value associated with a given key. This method returns immediately and invoke the passed block in background queue when the operation finished.

Parameters

- key

  A string identifying the value. If nil, just return nil.

- block

  A block which will be invoked in background queue when finished.



### removeAllObjects 

```
- (void)removeAllObjects
```

Discussion

Empties the cache. This method may blocks the calling thread until file delete finished.





### removeAllObjectsWithBlock:

```
- (void)removeAllObjectsWithBlock:(void ( ^ ) ( void ))*block*
```

Discussion

Empties the cache. This method returns immediately and invoke the passed block in background queue when the operation finished.

Parameters

- block

  A block which will be invoked in background queue when finished.





### removeAllObjectsWithProgressBlock:endBlock:

```
- (void)removeAllObjectsWithProgressBlock:(nullable void ( ^ ) ( int removedCount , int totalCount ))*progress* endBlock:(nullable void ( ^ ) ( BOOL error ))*end*
```

Discussion

Empties the cache with block. This method returns immediately and executes the clear operation with block in background.

**Warning:** You should not send message to this instance in these blocks.

Parameters

- progress

  This block will be invoked during removing, pass nil to ignore.

- end

  This block will be invoked at the end, pass nil to ignore.





### removeObjectForKey: 

```
- (void)removeObjectForKey:(NSString *)*key*
```

Discussion

Removes the value of the specified key in the cache. This method may blocks the calling thread until file delete finished.

Parameters

- key

  The key identifying the value to be removed. If nil, this method has no effect.



### removeObjectForKey:withBlock: 

```
- (void)removeObjectForKey:(NSString *)*key* withBlock:(nullable void ( ^ ) ( NSString *key ))*block*
```

Discussion

Removes the value of the specified key in the cache. This method returns immediately and invoke the passed block in background queue when the operation finished.

Parameters

- key

  The key identifying the value to be removed. If nil, this method has no effect.

- block

  A block which will be invoked in background queue when finished.





### setObject:forKey:

```
- (void)setObject:(nullable id<NSCoding>)*object* forKey:(NSString *)*key*
```

Discussion

Sets the value of the specified key in the cache. This method may blocks the calling thread until file write finished.

Parameters

- object

  The object to be stored in the cache. If nil, it calls [`removeObjectForKey:`](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/removeObjectForKey:).

- key

  The key with which to associate the value. If nil, this method has no effect.





### setObject:forKey:withBlock:

```
- (void)setObject:(nullable id<NSCoding>)*object* forKey:(NSString *)*key* withBlock:(nullable void ( ^ ) ( void ))*block*
```

Discussion

Sets the value of the specified key in the cache. This method returns immediately and invoke the passed block in background queue when the operation finished.

Parameters

- object

  The object to be stored in the cache. If nil, it calls [`removeObjectForKey:`](http://cocoadocs.org/docsets/YYCache/1.0.4/Classes/YYCache.html#//api/name/removeObjectForKey:).

- block

  A block which will be invoked in background queue when finished.



# YYMemoryCache



```

    YYMemoryCache *memoryCache = [YYMemoryCache new];
    memoryCache.name = name;
```

