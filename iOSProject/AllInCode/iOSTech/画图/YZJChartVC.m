//
//  YZJChartVC.m
//  AllInCode
//
//  Created by hd on 2021/4/7.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJChartVC.h"
#import "YZJUIBezierPathVC.h"

@interface YZJChartVC ()

@end

@implementation YZJChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容不可点击
//    [self addTitle:@"title" subTitle:@"subTitle"];

    LMJWordArrowItem *item02 = [LMJWordArrowItem itemWithTitle:@"UIBezierPath" subTitle:nil destVc:@"YZJUIBezierPathVC"];
    self.addItem(item02);
}



@end
