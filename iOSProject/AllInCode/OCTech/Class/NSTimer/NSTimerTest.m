//
//  NSTimerTest.m
//  OCTest
//
//  Created by yangzijiang on 10/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSTimerTest.h"

@interface NSTimerTest ()

@property (strong, nonatomic) NSTimer *timer;

@end


@implementation NSTimerTest
+ (instancetype)defaultInstance {
    static NSTimerTest *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)startTimer{
    NSLog(@"startTimer start");
    // 不需要调动[self.timer fire]方法，就会在指定的时间后调用@selector对应的方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
}

- (void)startTimerFire{
    NSLog(@"startTimerFire start");
    // 立马调用@selector对应的方法，并且不会影响原定时任务的调用
    [self.timer fire];
}

- (void)timerSelector{
    NSLog(@"timerSelector start");
}
@end
