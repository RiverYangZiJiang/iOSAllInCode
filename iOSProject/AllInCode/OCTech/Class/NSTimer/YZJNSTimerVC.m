//
//  YZJNSTimerVC.m
//  AllInCode
//
//  Created by hd on 2021/5/8.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJNSTimerVC.h"

@interface YZJNSTimerVC ()
/// 会造成循环引用，在viewWillDisappear中invalidate则不会造成循环引用
@property (nonatomic, weak) NSTimer *weakTimer;

/// 会造成循环引用，在viewWillDisappear中invalidate则不会造成循环引用
@property (nonatomic, strong) NSTimer *strongTimer;

/// 不在viewWillDisappear中invalidate也不会造成循环引用，iOS10开始系统提供block方式调用；iOS10之前使用NSTimer+YYAdd里提供的block方式调用
@property (nonatomic, strong) NSTimer *blockTimer;

/// 准确度
@property (nonatomic, weak) NSTimer *accurateTimer;

///
@property (nonatomic, strong) CADisplayLink * displayLink;
@end

@implementation YZJNSTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    WeakSelf
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"开启weak特性的定时器" subTitle:@"是否会造成循环引用?" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf weakTimer];
    }]);
    
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"开启strong特性的定时器" subTitle:@"是否会造成循环引用?" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf strongTimer];
    }]);
    
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"开启block方式的定时器" subTitle:@"是否会造成循环引用?" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf blockTimer];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"NSTimer准确度" subTitle:@"如果在定时器block里循环10亿次，则定时器是否准确?" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf accurateTimer];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"CADisplayLink" subTitle:@"定时周期为多少？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf displayLink];
    }]);
    

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.weakTimer invalidate];
    [self.strongTimer invalidate];
    [self.displayLink invalidate];  // 必须invalidate，否则会造成循环引用
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
//    NSLog(@"%s,self.weakTimer: %@, self.strongTimer: %@", __func__, self.weakTimer, self.strongTimer);
    
    [self.blockTimer invalidate];  // 必须调用，否则定时器会一直执行
    self.blockTimer = nil;
}

#pragma mark - 循环引用
- (NSTimer *)weakTimer {
    if (!_weakTimer) {
        _weakTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    }
    return _weakTimer;
}

- (void)handleTimer {
    NSLog(@"%s", __func__);
}

- (NSTimer *)strongTimer {
    if (!_strongTimer) {
        _strongTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    }
    return _strongTimer;
}

- (NSTimer *)blockTimer {
    if (!_blockTimer) {
        _blockTimer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            NSLog(@"%s", __func__);
        } repeats:YES];
    }
    return _blockTimer;
}

#pragma mark - 准确度
- (NSTimer *)accurateTimer {
    if (!_accurateTimer) {
        _accurateTimer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            /// 循环执行10亿次，定时器就不再准确，如变成3秒执行一次
            int count = 0;
            for (int i = 0; i < 1000000000; i++) {
                count += i;
            }
            NSLog(@"%s", __func__);
        } repeats:YES];
    }
    return _accurateTimer;
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(logInfo)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}

//- (void)displayLink {
//    // 必须要释放，否则会造成循环引用
//    CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(logInfo)];
//    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//}

- (void)logInfo {
    NSLog(@"%s", __func__);
}


@end
