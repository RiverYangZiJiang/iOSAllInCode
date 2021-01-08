//
//  CPActivityController.m
//  ChargePlatform
//
//  Created by HMDS on 2021/1/5.
//  Copyright © 2021 EverGrande. All rights reserved.
//

#import "CPActivityController.h"
#import "UILabel+CPExtension.h"

@interface CPActivityController ()
/// 自定义导航条
@property (nonatomic, strong) UIView *customNavigationBar;
@property (nonatomic, strong) UIImageView *topBackgroundImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CPActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = NO;
    self.titleLabel.text = @"福利中心";
    
    [self.view addSubview:self.topBackgroundImageView];
    [self.view addSubview:self.titleLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.topBackgroundImageView.top = 0;
    self.topBackgroundImageView.left = 0;
    self.topBackgroundImageView.width = self.view.width;
    self.topBackgroundImageView.height = SH(161);
    
    self.titleLabel.top = CPNavigationBarHeight + SH(12);
    self.titleLabel.centerX = self.view.centerX;
    self.titleLabel.width = self.view.width;
    self.titleLabel.height = SH(24);
    
    
}

#pragma mark - Getters & Setters
- (UIView *)customNavigationBar {
    if (!_customNavigationBar) {
        _customNavigationBar = [[UIView alloc] init];
    }
    return _customNavigationBar;
}

- (UILabel *)titleLabel{
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:16] textAlignment:NSTextAlignmentCenter nuberOflines:1];
    }
    return _titleLabel;
}

- (UIImageView *)topBackgroundImageView {
    if (!_topBackgroundImageView) {
        _topBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_activity"]];
    }
    return _topBackgroundImageView;
}

@end
