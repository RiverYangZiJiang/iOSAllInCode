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
#import "YZJNSDateVC.h"
#import "YZJNSInvocationVC.h"

@interface YZJOCTechVC ()

@end

@implementation YZJOCTechVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"Block" subTitle:nil];
    item00.destVc = [BlockTestViewController class];
    
    LMJWordArrowItem *item01 = [LMJWordArrowItem itemWithTitle:@"Math" subTitle:nil];
    item01.destVc = [YZJMathVC class];
    
    LMJWordArrowItem *item02 = [LMJWordArrowItem itemWithTitle:@"NSDate" subTitle:nil destVc:@"YZJNSDateVC"];
    
    LMJWordArrowItem *item03 = [LMJWordArrowItem itemWithTitle:@"NSInvocation" subTitle:nil destVc:@"YZJNSInvocationVC"];
    
    LMJWordArrowItem *item04 = [LMJWordArrowItem itemWithTitle:@"MultiThread" subTitle:nil destVc:@"YZJMultiThreadVC"];
    
    LMJWordArrowItem *item05 = [LMJWordArrowItem itemWithTitle:@"NSTimer" subTitle:nil destVc:@"YZJNSTimerVC"];
    LMJWordArrowItem *item06 = [LMJWordArrowItem itemWithTitle:@"Memory" subTitle:nil destVc:@"YZJMemoryVC"];
    
    
    LMJWordArrowItem *item07 = [LMJWordArrowItem itemWithTitle:@"Swift" subTitle:nil destVc:@"YZJSwiftOCVC"];
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item07, item00, item01, item02, item03, item04, item05, item06] andHeaderTitle:nil footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];

}

@end
