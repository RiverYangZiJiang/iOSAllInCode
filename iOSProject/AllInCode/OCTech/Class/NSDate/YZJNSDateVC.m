//
//  YZJNSDateVC.m
//  AllInCode
//
//  Created by hd on 2021/3/26.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJNSDateVC.h"
#import "NSDate+YZJNSDate.h"
@interface YZJNSDateVC ()

@end

@implementation YZJNSDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容不可点击
    [self addTitle:@"当前时间13位时间戳" subTitle:[NSDate getCurr13BitTime]];

    // 展示内容并且可以点击，section和item
//    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"MLUI" subTitle:@"自定义UI"];
//    item00.destVc = [YZJUIViewController class];
//    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:@"UI" footerTitle:nil];
//    [self.sections addObjectsFromArray:@[section0]];
    
}



@end
