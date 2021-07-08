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
#import "YZJLeftRightAlignment.h"

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
    
    LMJWordArrowItem *item02 = [LMJWordArrowItem itemWithTitle:@"文字左右对齐" subTitle:nil];
    item02.destVc = [YZJLeftRightAlignment class];
    
    self.addItem(item02);
    
    self.addItem([LMJWordArrowItem itemWithTitle:@"换行" subTitle:nil destVc:@"YZJChangeLineViewController"]);
    
    self.addItem([LMJWordArrowItem itemWithTitle:@"YYLabel" subTitle:@"中间文本可点击" destVc:@"YZJYYLabelViewController"]);
    
}



@end
