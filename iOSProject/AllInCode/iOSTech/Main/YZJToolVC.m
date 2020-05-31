//
//  YZJToolVC.m
//  iOSAllInCode
//
//  Created by 杨子江 on 3/10/19.
//  Copyright © 2019 杨子江. All rights reserved.
//

#import "YZJToolVC.h"
#import "YZJOpenSourceVC.h"

@interface YZJToolVC ()

@end

@implementation YZJToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 需要跳转到其他界面
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"OpenSource开源" subTitle:@""];
    item00.destVc = [YZJOpenSourceVC class];
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:nil footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
}

@end
