//
//  YZJViewController.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJViewController.h"
#import "LMJLifeCycleViewController.h"

@interface YZJViewController ()

@end

@implementation YZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"UIViewController生命周期" subTitle:nil];
    item00.destVc = [LMJLifeCycleViewController class];
    self.addItem(item00);
}

@end
