//
//  LMJImageViewController.m
//  iOSProject
//
//  Created by yangzijiang on 2018/4/21.
//  Copyright © 2018 github.com/njhu. All rights reserved.
//

#import "LMJImageViewController.h"
#import "YZJImageZoomViewController.h"
#import "YZJCallViewController.h"

@interface LMJImageViewController ()

@end

@implementation LMJImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建单元格cell
    LMJWordArrowItem *item0 = [LMJWordArrowItem itemWithTitle:@"图片缩放" subTitle:nil];
    item0.destVc = [YZJImageZoomViewController class];
    
    LMJWordArrowItem *item1 = [LMJWordArrowItem itemWithTitle:@"Call" subTitle:nil];
    item1.destVc = [YZJCallViewController class];
    
    // 2.创建节section
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item0, item1] andHeaderTitle:@"Header" footerTitle:@"Footer"];
    
    // 3.添加节到节数组
    [self.sections addObject:section0];
}



@end
