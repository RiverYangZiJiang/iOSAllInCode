//
//  YZJViewController.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJViewController.h"
#import "LMJLifeCycleViewController.h"
#import "CPActivityController.h"

@interface YZJViewController ()

@end

@implementation YZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"UIViewController生命周期" subTitle:nil];
    item00.destVc = [LMJLifeCycleViewController class];
    
    LMJWordArrowItem *item01 = [LMJWordArrowItem itemWithTitle:@"自定义导航条" subTitle:nil];
    item01.destVc = [CPActivityController class];
    
    self.addItem(item00);
    self.addItem(item01);
}

@end
