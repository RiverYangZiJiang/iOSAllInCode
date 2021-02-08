//
//  YZJNetworkLayerVC.m
//  AllInCode
//
//  Created by hd on 2021/2/8.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJNetworkLayerVC.h"
#import "NSURLTestVC.h"

@interface YZJNetworkLayerVC ()

@end

@implementation YZJNetworkLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容不可点击
//    [self addTitle:@"title" subTitle:@"subTitle"];

    // 展示内容并且可以点击，section和item
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"NSURLTestVC" subTitle:@"NSURLTestVC"];
    item00.destVc = [NSURLTestVC class];
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:@"1" footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
    
}



@end
