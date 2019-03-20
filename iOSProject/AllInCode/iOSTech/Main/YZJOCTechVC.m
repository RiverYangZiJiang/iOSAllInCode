//
//  YZJOCTechVC.m
//  iOSAllInCode
//
//  Created by 杨子江 on 3/10/19.
//  Copyright © 2019 杨子江. All rights reserved.
//

#import "YZJOCTechVC.h"
#import "BlockTestViewController.h"
#import "YZJMathVC.h"

@interface YZJOCTechVC ()

@end

@implementation YZJOCTechVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"Block" subTitle:nil];
    item00.destVc = [BlockTestViewController class];
    
    LMJWordArrowItem *item01 = [LMJWordArrowItem itemWithTitle:@"Math" subTitle:nil];
    item01.destVc = [YZJMathVC class];
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00, item01] andHeaderTitle:nil footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];

}

@end
