//
//  YZJCountdownLabel.m
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJCountdownLabel.h"

@interface YZJCountdownLabel ()
//{
//    dispatch_source_t _timer;
//}

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, strong) UILabel *timeLabel;

//@property (nonatomic, weak) void(^doneBlock)(void);

@end

@implementation YZJCountdownLabel

- (instancetype)initWithSeconds:(NSUInteger)seconds delegate:(id<YZJCountdownLabelDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.countdownLabelDelegate = delegate;
        __weak __typeof(self) weakSelf = self;
        
        if (_timer == nil) {
            __block NSInteger timeout = seconds; // 倒计时时间
            
            if (timeout != 0) {
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC,  0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    __strong __typeof(weakSelf) strongSelf = weakSelf;
                    if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                        dispatch_source_cancel(_timer);
                        _timer = nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            strongSelf.text = @"00";
                            // 如果需用block，不管用self/weakSelf/strongSelf都会造成循环引用
//                            if (strongSelf.doneBlock) {
//                                strongSelf.doneBlock();
//                            }
                            if([strongSelf.countdownLabelDelegate respondsToSelector:@selector(countDownDone)]) {
                                [strongSelf.countdownLabelDelegate countDownDone];
                            }
                        });
                    } else { // 倒计时重新计算
                        NSInteger second = timeout;
                        NSString *strTime = [NSString stringWithFormat:@"%02ld", second];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            strongSelf.text = strTime;
                            
                        });
                        timeout--; // 递减 倒计时-1(总时间以秒来计算)
                    }
                });
                dispatch_resume(_timer);
            }
        }
    }
    return self;
}

- (void)releaseTimer {
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
    dispatch_source_cancel(_timer);
    _timer = nil;
}

- (void)dealloc {
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
//    [self releaseTimer];
}

@end
