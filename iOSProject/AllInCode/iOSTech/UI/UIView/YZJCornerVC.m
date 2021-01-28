//
//  YZJCornerVC.m
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJCornerVC.h"
#import "UIView+Category.h"
#import "UILabel+CPExtension.h"

@interface YZJCornerVC ()
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *titleLabel1;
@end

@implementation YZJCornerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleLabel1];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.titleLabel.top = 100;
    self.titleLabel.left = 0;
    self.titleLabel.width = self.view.width;
    self.titleLabel.height = 100;
    [self.titleLabel drawCornerWithTopCornerRadius:6 bottomCornerRadius:6];
    
    self.titleLabel1.top = 300;
    self.titleLabel1.left = 20;
    self.titleLabel1.width = self.view.width - 40;
    self.titleLabel1.height = 100;
    [self.titleLabel1 drawCornerWithCornerRadius:4 corner:UIRectCornerTopLeft | UIRectCornerBottomRight];
}

- (UILabel *)titleLabel{
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#A4A9AF"] backgroundColor:[UIColor whiteColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:1];
        _titleLabel.text = @"123";
    }
    return _titleLabel;
}

- (UILabel *)titleLabel1{
    if(!_titleLabel1) {
        _titleLabel1 = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#A4A9AF"] backgroundColor:[UIColor whiteColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:1];
        _titleLabel1.text = @"上左下右圆角";
    }
    return _titleLabel1;
}

@end
