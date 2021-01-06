//
//  YZJUIViewAnimationVC.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJUIViewAnimationVC.h"
#import "YZJWaterWaveVC.h"

@implementation YZJUIViewAnimationVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // 表格底部往上移ttabBar的高度
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.height;
    self.tableView.contentInset = edgeInsets;
    
    LMJWordArrowItem *item00= [LMJWordArrowItem itemWithTitle:@"波浪动画" subTitle:@"TYWaterWaveView"];
    item00.destVc = [YZJWaterWaveVC class];
    
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:@"动画" footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
}


@end
