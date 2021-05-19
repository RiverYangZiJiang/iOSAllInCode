//
//  YZJMemoryVC.m
//  AllInCode
//
//  Created by hd on 2021/5/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJMemoryVC.h"

@interface YZJMemoryVC ()

@end

@implementation YZJMemoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"在@autoreleasepool中使用for循环" subTitle:@"是否会导致内存暴涨？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf useForLoopInAutoreleasepool];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"在for循环中使用@autoreleasepool" subTitle:@"是否会导致内存暴涨？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf useAutoreleasepoolInForLoop];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"localVariable" subTitle:@"是否会在}后立即释放？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf localVariable];
    }]);
}


#pragma mark - @autoreleasepool
- (void)useForLoopInAutoreleasepool {
    // 内存暴涨，最高到24.7MB，执行完还一直保持在24.6，没有下降
    @autoreleasepool {
        for (int i = 0; i < 99999; ++i) {
            YZJMemoryVC *p = [[YZJMemoryVC alloc] init];
        }  // 对象p会被加入到自动释放池，当ARC下代码执行到右大括号时（相当于MRC执行代码[pool drain];）会对池中所有对象依次执行一次release操作
    }
}

- (void)useAutoreleasepoolInForLoop {
    // 内存不暴涨，一直保持在21.3MB，执行完下降到21MB
    for (int i = 0; i < 99999; ++i) {
        @autoreleasepool {
            YZJMemoryVC *p = [[YZJMemoryVC alloc] init];
        }
    }
}

- (void)localVariable {
    NSString *str;
    @autoreleasepool {
        str = @"123";
        NSLog(@"str in @autoreleasepool: %@", str);  // 123
    }
    NSLog(@"str out @autoreleasepool: %@", str);  // 123
}
@end
