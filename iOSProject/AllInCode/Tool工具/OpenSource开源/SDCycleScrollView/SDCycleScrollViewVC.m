//
//  SDCycleScrollViewVC.m
//  AllInCode
//
//  Created by 杨子江 on 1/10/21.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "SDCycleScrollViewVC.h"

@interface SDCycleScrollViewVC ()

@end

@implementation SDCycleScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 网络加载图片的轮播器
    CGRect frame = CGRectMake(0, 100, ScreenWidth, 200);
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
//    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    
    // 本地加载图片的轮播器
    NSArray *array = @[@"bg_activity", @"bg_activity"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageNamesGroup:array];
    cycleScrollView.layer.cornerRadius = 6;
    cycleScrollView.layer.masksToBounds = YES;
    [self.view addSubview:cycleScrollView];
}



@end
