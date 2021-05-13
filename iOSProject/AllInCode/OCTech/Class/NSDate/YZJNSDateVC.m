//
//  YZJNSDateVC.m
//  AllInCode
//
//  Created by hd on 2021/3/26.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJNSDateVC.h"
#import "NSDate+YZJNSDate.h"
@interface YZJNSDateVC ()
///
@property (nonatomic, strong) NSDate *date;
@end

@implementation YZJNSDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容不可点击
    [self addTitle:@"当前时间13位时间戳" subTitle:[NSDate getCurr13BitTime]];

    WeakSelf
    self.date = [NSDate date];
    self.addItem([LMJWordItem itemWithTitle:@"哪个方法计算两个时间之间的间隔？" subTitle:@"整数部分从时分秒毫秒哪个开始？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf photoButtonDidPressed];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"CACurrentMediaTime" subTitle:@"可以用来做啥？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf CACurrentMediaTimeTest];
    }]);
    
    
}

- (void)photoButtonDidPressed {
    NSDate *date = [NSDate date];
    // 返回时间整数部分从秒开始，如6.666表示6.666秒
    CGFloat timeInterval = [date timeIntervalSinceDate:self.date];
    [self addTitle:@"已经过了" subTitle:[NSString stringWithFormat:@"%f秒", timeInterval]];
    [self.tableView reloadData];
}

- (void)CACurrentMediaTimeTest{
    // Returns the current absolute time, in seconds.
    NSTimeInterval start = CACurrentMediaTime();
    [NSThread sleepForTimeInterval:1];
    NSTimeInterval delta = CACurrentMediaTime() - start;
    NSLog(@"耗时：%f",  delta);  // 耗时：1.001024
    [self addTitle:@"已经过了" subTitle:[NSString stringWithFormat:@"%f秒", delta]];
    [self.tableView reloadData];
}

@end
