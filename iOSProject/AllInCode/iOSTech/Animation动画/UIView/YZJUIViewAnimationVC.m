//
//  YZJUIViewAnimationVC.m
//  AllInCode
//
//  Created by hd on 2021/2/18.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJUIViewAnimationVC.h"
#import "UILabel+CPExtension.h"

@interface YZJUIViewAnimationVC ()

@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UILabel *passwordLabel;


@property (nonatomic, strong) UILabel *loginLabel;

@end

@implementation YZJUIViewAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.loginLabel];
    self.loginLabel.alpha = 0;
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(-44);
        make.height.mas_equalTo(44);
    }];
    
    self.userNameLabel.frame = CGRectMake(-100, 100, 100, 100);
    self.passwordLabel.frame = CGRectMake(-100, 200, 100, 100);
    self.loginLabel.frame = CGRectMake(100, 300, 100, 100);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.userNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
//    [UIView animateWithDuration:0.4 animations:^{
//        [self.view layoutIfNeeded];
//    }];

    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.userNameLabel.lmj_x = 100;
//    }];
    [UIView animateWithDuration:0.5 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.passwordLabel.lmj_x = 100;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration: 0.2 animations: ^{
          self.loginLabel.alpha = 1;
        }];
    }];
}

- (UILabel *)userNameLabel{
    if(!_userNameLabel) {
        _userNameLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#0E1F33"] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentCenter nuberOflines:1];
        _userNameLabel.text = @"abcedfghi";
    }
    return _userNameLabel;
}

- (UILabel *)passwordLabel{
    if(!_passwordLabel) {
        _passwordLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#0E1F33"] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:1];
        _passwordLabel.text = @"passwordLabel";
    }
    return _passwordLabel;
}

- (UILabel *)loginLabel{
    if(!_loginLabel) {
        _loginLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#0E1F33"] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:1];
        _loginLabel.text = @"login";
    }
    return _loginLabel;
}

@end
