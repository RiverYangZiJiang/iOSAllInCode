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

    self.date = [NSDate date];
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoButtonDidPressed:)];
    self.tableView.userInteractionEnabled = YES;  // 必须设置才能交互
    [self.tableView addGestureRecognizer:gr];
    // 展示内容并且可以点击，section和item
//    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"MLUI" subTitle:@"自定义UI"];
//    item00.destVc = [YZJUIViewController class];
//    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:@"UI" footerTitle:nil];
//    [self.sections addObjectsFromArray:@[section0]];
    
    
}

- (void)photoButtonDidPressed:(UIGestureRecognizer *)gr {
    NSDate *date = [NSDate date];
    // 返回时间整数部分从秒开始，如6.666表示6.666秒
    CGFloat timeInterval = [date timeIntervalSinceDate:self.date];
    [self addTitle:@"已经过了" subTitle:[NSString stringWithFormat:@"%f秒", timeInterval]];
    [self.tableView reloadData];
}



@end
