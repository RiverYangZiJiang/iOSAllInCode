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
@end

@implementation YZJCornerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.titleLabel.top = 100;
    self.titleLabel.left = 0;
    self.titleLabel.width = self.view.width;
    self.titleLabel.height = SH(161);
    [self.titleLabel drawCornerWithTopCornerRadius:6 bottomCornerRadius:6];
}

- (UILabel *)titleLabel{
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#A4A9AF"] backgroundColor:[UIColor whiteColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:1];
        _titleLabel.text = @"123";
    }
    return _titleLabel;
}

@end
