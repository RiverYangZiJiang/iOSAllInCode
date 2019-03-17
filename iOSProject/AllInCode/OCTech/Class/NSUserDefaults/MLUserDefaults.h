//
//  MLUserDefaults.h
//  OCTest
//
//  Created by yangzijiang on 2019/2/23.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLUserDefaults : NSObject
+ (void)userDefaultsTest;

/**
 NSUserDefaults性能优化问题 https://blog.csdn.net/petyou123/article/details/50800837
 实测在10万个key值的情况下，通过NSUserDefaults来读取value是1ms级别的，而如果从自己写的plist里读取则是0.1s级别的开销。但是，如果用plist文件自己在应用里写入1个10万条记录的文件是1s级别的开销，而同时写入10万条NSUserDefaults键值对则是10s级别的延迟。原因在于，在创建key/value pair时，要在内存中也创建一个相应的映射，而系统时不时地调用synchronize方法会导致创建key/value pair被阻塞。
 
 关于NSUserDefaults的秘密 https://www.cnblogs.com/yzvictory/p/5762483.html
 
 iOS-浅谈NSUserDefaults保存数据的缺点以及改进方案：UDUserDefaultsModel https://www.jianshu.com/p/681ef055f716
 
 https://github.com/zhengbomo/BMUserDefault
 
 */
@end

NS_ASSUME_NONNULL_END
