//
//  YZJUILabelVC.m
//  AllInCode
//
//  Created by hd on 2021/1/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJUILabelVC.h"
#import "YZJCountDownVC.h"
#import "YZJVerticalStringVC.h"

@interface YZJUILabelVC ()

@end

@implementation YZJUILabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"倒计时" subTitle:nil];
    item00.destVc = [YZJCountDownVC class];
    
    self.addItem(item00);
    
    LMJWordArrowItem *item01 = [LMJWordArrowItem itemWithTitle:@"竖排文字" subTitle:nil];
    item01.destVc = [YZJVerticalStringVC class];
    
    self.addItem(item01);
}



@end
