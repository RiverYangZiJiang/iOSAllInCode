//
//  SDCycleScrollViewVC.m
//  AllInCode
//
//  Created by 杨子江 on 1/10/21.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "SDCycleScrollViewVC.h"

@interface SDCycleScrollViewVC ()
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation SDCycleScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 网络加载图片的轮播器
    
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
//    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    
    [self.view addSubview:self.cycleScrollView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.cycleScrollView.frame = CGRectMake(0, 100, ScreenWidth, 200);
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        // 本地加载图片的轮播器
        NSArray *array = @[@"bg_activity", @"bg_activity"];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:array];
        _cycleScrollView.layer.cornerRadius = 6;
        _cycleScrollView.layer.masksToBounds = YES;
    }
    return _cycleScrollView;
}




@end
