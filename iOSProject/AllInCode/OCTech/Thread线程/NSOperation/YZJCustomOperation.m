//
//  YZJCustomOperation.m
//  AllInCode
//
//  Created by hd on 2021/4/29.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJCustomOperation.h"

@implementation YZJCustomOperation
/// 可以通过重写 main 或者 start 方法 来定义自己的 NSOperation 对象。重写main方法比较简单，我们不需要管理操作的状态属性 isExecuting 和 isFinished。当 main 执行完返回的时候，这个操作就结束了。
- (void)main {
    if (!self.isCancelled) {
        NSLog(@"%s %@", __func__, [NSThread currentThread]); // 打印当前线程
    }
}
@end
