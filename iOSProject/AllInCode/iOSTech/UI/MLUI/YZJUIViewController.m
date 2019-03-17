//
//  YZJUIViewController.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJUIViewController.h"
#import "MLTopToastViewVC.h"

@interface YZJUIViewController ()

@end

@implementation YZJUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"MLTopToastViewVC" subTitle:nil];
    item00.destVc = [MLTopToastViewVC class];
    self.addItem(item00);
}

@end
