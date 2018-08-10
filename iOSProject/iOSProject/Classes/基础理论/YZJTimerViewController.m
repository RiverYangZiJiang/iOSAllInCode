//
//  YZJTimerViewController.m
//  iOSProject
//
//  Created by yangzijiang on 2018/8/10.
//  Copyright © 2018 github.com/njhu. All rights reserved.
//

#import "YZJTimerViewController.h"

@interface YZJTimerViewController ()

@end

/**
 http://www.cocoachina.com/ios/20180416/23018.html
 */
@implementation YZJTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建单元格cell
    LMJWordItem *item0 = [LMJWordItem itemWithTitle:@"NSDelayedPerforming" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        NSLog(@"123");
        
        // 三秒过后在当前线程执行，不会阻塞当前线程
        [self performSelector:@selector(testSelectorDelay) withObject:nil afterDelay:3];
        
        NSLog(@"321");
    }];
    
    LMJWordItem *item1 = [LMJWordItem itemWithTitle:@"dispatch_after" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        NSLog(@"123");
        // 3秒钟之后执行 block
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@ %s", [NSThread currentThread], __func__);
        });
        NSLog(@"321");
    }];
    
    // 2.创建节section
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item0, item1] andHeaderTitle:@"Header" footerTitle:@"Footer"];
    
    // 3.添加节到节数组
    [self.sections addObject:section0];
}

- (void)testSelectorDelay {
    NSLog(@"%@ %s", [NSThread currentThread], __func__);  // <NSThread: 0x1c0073340>{number = 1, name = main} -[YZJTimerViewController testSelectorDelay]
}

@end
