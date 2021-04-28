//
//  YZJCountDownVC.m
//  AllInCode
//
//  Created by 杨子江 on 1/12/21.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJCountDownVC.h"
#import "YZJCountDownTool.h"
#import "YZJCountdownLabel.h"

@interface YZJCountDownVC ()<YZJCountdownLabelDelegate>
{
    dispatch_source_t _timer;
}

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, weak) YZJCountdownLabel *countdownLabel;
@end

@implementation YZJCountDownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.countdownLabel];
    [self countDown];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat timeW = ceil([self.timeLabel widthForSingleLine]);
    CGFloat timeH = [self.timeLabel heightForWidth:timeW];
    NSLog(@"%s, timeW: %f, timeH: %f", __func__, timeW, timeH);
    self.timeLabel.top = 100;
    self.timeLabel.left = 100;
//    self.timeLabel.width = self.view.width;
    self.timeLabel.width = 143;
    self.timeLabel.height = timeH;
    
    self.countdownLabel.top = 200;
    self.countdownLabel.left = 100;
    self.countdownLabel.width = self.view.width;
    self.countdownLabel.height = 20;
}

- (void)dealloc {
//    [self.countdownLabel releaseTimer];
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
}

- (void)countDown {
    // 倒计时的时间 测试数据
    NSString *deadlineStr = @"2021-01-12 22:00:00";
    // 当前时间的时间戳
    NSString *nowStr = [YZJCountDownTool getCurrentTimeyyyymmdd];
    // 计算时间差值
    NSInteger secondsCountDown = [YZJCountDownTool getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
    
    __weak __typeof(self) weakSelf = self;
    
    if (_timer == nil) {
        __block NSInteger timeout = secondsCountDown; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.timeLabel.text = @"当前活动已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"活动倒计时 %02ld : %02ld : %02ld", hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days == 0) {
                            weakSelf.timeLabel.text = strTime;
                        } else {
                            weakSelf.timeLabel.text = [NSString stringWithFormat:@"使用GCD来实现活动倒计时            %ld天 %02ld : %02ld : %02ld", days, hours, minute, second];
                        }
                        
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}


- (UILabel *)timeLabel{
    if(!_timeLabel) {
        _timeLabel = [UILabel labelWithText:@"当前活动已结束" font:[UIFont systemFontOfSize:20] textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    }
    return _timeLabel;
}


- (void)countDownDone {
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
}

- (YZJCountdownLabel *)countdownLabel{
    if(!_countdownLabel) {
        _countdownLabel = [[YZJCountdownLabel alloc] initWithSeconds:20 delegate:self];
        _countdownLabel.textColor = [UIColor greenColor];
        _countdownLabel.font = [UIFont systemFontOfSize:14];
        _countdownLabel.countdownLabelDelegate = self;
    }
    return _countdownLabel;
}

@end
