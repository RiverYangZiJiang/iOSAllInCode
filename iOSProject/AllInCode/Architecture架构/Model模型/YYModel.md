#  YYModel

高性能 iOS/OSX 模型转换框架，无侵入性(模型无需继承自其他基类)，还能一句话实现Coding、Coping/hash/equal/description方法

实现原理：利用oc的运行时反射实现json字符串和对象的相互转换

参考文献

1.YYModel实现原理探究

### Coding/Copying/hash/equal/description

```
@interface YYShadow :NSObject <NSCoding, NSCopying>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGSize size;
@end

@implementation YYShadow
// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }
@end
```



## 特性

- **高性能**: 模型转换性能接近手写解析代码。
- **自动类型转换**: 对象类型可以自动转换，详情见下方表格。
- **类型安全**: 转换过程中，所有的数据类型都会被检测一遍，以保证类型安全，避免崩溃问题。
- **无侵入性**: 模型无需继承自其他基类。
- **轻量**: 该框架只有 5 个文件 (包括.h文件)。
- **文档和单元测试**: 文档覆盖率100%, 代码覆盖率99.6%。

## 侵入性：

Mantle 和 JSONModel 都需要 Model 继承自某个基类，灵活性稍差，但功能丰富。

YYModel、MJExtension 都是采用 Category 方式来实现功能，比较灵活，无侵入。
但注意 MJExtension 为 NSObject/NSString 添加了一些没有前缀的方法，且方法命名比较通用，可能会和一个工程内的其他类有冲突。

FastEasyMapping 采用工具类来实现 Model 转换的功能，最为灵活，但使用很不方便。

## 结论：

如果需要一个稳定、功能强大的 Model 框架，Mantle 是最佳选择，它唯一的缺点就是性能比较差。
如果对功能要求并不多，但对性能有更高要求时，可以试试我的 YYModel。

Swift 相关的几个库性能都比较差，非 Swift 项目不推荐使用。

最后提一句，如果对性能、网络流量等有更高的要求，就不要再用 JSON 了，建议改用 protobuf/FlatBuffers 这样的方案。JSON 转换再怎么优化，在性能和流量方面还是远差于二进制格式的。



Mantle
Github 官方团队开发的 JSON 模型转换库，Model 需要继承自 MTLModel。功能丰富，文档完善，使用广泛。

MJExtension
国内开发者”小码哥”开发的 JSON 模型库，号称性能超过 JSONModel 和 Mantle，使用简单无侵入。国内有大量使用者。



## 附: YYModel 性能优化的几个 Tip：

\1. 缓存
Model JSON 转换过程中需要很多类的元数据，如果数据足够小，则全部缓存到内存中。

\2. 查表
当遇到多项选择的条件时，要尽量使用查表法实现，比如 switch/case，C Array，如果查表条件是对象，则可以用 NSDictionary 来实现。

\3. 避免 KVC
Key-Value Coding 使用起来非常方便，但性能上要差于直接调用 Getter/Setter，所以如果能避免 KVC 而用 Getter/Setter 代替，性能会有较大提升。

\4. 避免 Getter/Setter 调用
如果能直接访问 ivar，则尽量使用 ivar 而不要使用 Getter/Setter 这样也能节省一部分开销。

\5. 避免多余的内存管理方法
在 ARC 条件下，默认声明的对象是 __strong 类型的，赋值时有可能会产生 retain/release 调用，如果一个变量在其生命周期内不会被释放，则使用 __unsafe_unretained 会节省很大的开销。

访问具有 __weak 属性的变量时，实际上会调用 objc_loadWeak() 和 objc_storeWeak() 来完成，这也会带来很大的开销，所以要避免使用 __weak 属性。

创建和使用对象时，要尽量避免对象进入 autoreleasepool，以避免额外的资源开销。

\6. 遍历容器类时，选择更高效的方法
相对于 Foundation 的方法来说，CoreFoundation 的方法有更高的性能，用 CFArrayApplyFunction() 和 CFDictionaryApplyFunction() 方法来遍历容器类能带来不少性能提升，但代码写起来会非常麻烦。

\7. 尽量用纯 C 函数、内联函数
使用纯 C 函数可以避免 ObjC 的消息发送带来的开销。如果 C 函数比较小，使用 inline 可以避免一部分压栈弹栈等函数调用的开销。

\8. 减少遍历的循环次数
在 JSON 和 Model 转换前，Model 的属性个数和 JSON 的属性个数都是已知的，这时选择数量较少的那一方进行遍历，会节省很多时间。







