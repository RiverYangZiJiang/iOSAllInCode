//
//  YZJUIViewController.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJUIViewController.h"
#import "MLTopToastViewVC.h"
#import "YZJUIAlertController.h"
#import "YZJFilterVC.h"
#import "SSStationSearchViewVC.h"

@interface YZJUIViewController ()

@end

@implementation YZJUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"MLTopToastViewVC" subTitle:nil];
    item00.destVc = [MLTopToastViewVC class];
    self.addItem(item00);
    
    LMJWordArrowItem *item01 = [LMJWordArrowItem itemWithTitle:@"YZJUIAlertController" subTitle:nil];
    item01.destVc = [YZJUIAlertController class];
    self.addItem(item01);
    
    LMJWordArrowItem *item02 = [LMJWordArrowItem itemWithTitle:@"YZJFilterVC" subTitle:@"箭头" destVc:@"YZJFilterVC"];
    self.addItem(item02);
    
    LMJWordArrowItem *item03 = [LMJWordArrowItem itemWithTitle:@"SSStationSearchViewVC" subTitle:@"箭头" destVc:@"SSStationSearchViewVC"];
    self.addItem(item03);
    
}

@end
