//
//  YZJAnimationVC.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJAnimationVC.h"
#import "YZJWaterWaveVC.h"
#import "YZJImageLoopViewController.h"
#import "YZJUIViewAnimationVC.h"
#import "YZJChartVC.h"

@implementation YZJAnimationVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // 表格底部往上移tabBar的高度
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.height;
    self.tableView.contentInset = edgeInsets;
    
    LMJWordArrowItem *item00= [LMJWordArrowItem itemWithTitle:@"波浪动画" subTitle:@"TYWaterWaveView"];
    item00.destVc = [YZJWaterWaveVC class];
    
    LMJWordArrowItem *item01= [LMJWordArrowItem itemWithTitle:@"图片循环旋转" subTitle:@""];
    item01.destVc = [YZJImageLoopViewController class];
    
    LMJWordArrowItem *item02= [LMJWordArrowItem itemWithTitle:@"UIView动画" subTitle:@""];
    item02.destVc = [YZJUIViewAnimationVC class];
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00, item01, item02] andHeaderTitle:@"动画" footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
    
    LMJWordArrowItem *item03 = [LMJWordArrowItem itemWithTitle:@"画图" subTitle:nil destVc:@"YZJChartVC"];
    self.addItem(item03);
}


@end
