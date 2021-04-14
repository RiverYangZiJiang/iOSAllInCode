//
//  SSStationSearchView.m
//  AllInCode
//
//  Created by hd on 2021/4/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "SSStationSearchView.h"
@interface SSStationSearchView ()<UITextFieldDelegate>
/// 左边的搜索图🔍
@property (nonatomic, strong) UIImageView *searchIV;
/// 文本输入
@property (nonatomic, strong) UITextField *textField;
@end

@implementation SSStationSearchView
+ (instancetype)searchViewWithPlaceholder:(NSString *)placeholder didSearchHandler:(void (^)(NSString *message))block {
    NSLog(@"%s", __func__);
    SSStationSearchView *searchView = [[SSStationSearchView alloc] init];
    searchView.textField.placeholder = placeholder;
    searchView.didSearchHandler = block;
    return searchView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"%s", __func__);
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.searchIV];
        [self addSubview:self.textField];
        
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2;
    }
    return self;
}

- (void)updateConstraints {
    NSLog(@"%s", __func__);
    [self.searchIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchIV.mas_right).offset(4);
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(18);
    }];
    
    [super updateConstraints];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(self.didSearchHandler) {
        self.didSearchHandler(textField.text);
    }
    return YES;
}

#pragma mark - Private
- (BOOL)becomeFirstResponder {
    return [self.textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [self.textField resignFirstResponder];
}

#pragma mark - Getters & Setters
- (UIImageView *)searchIV {
    if (!_searchIV) {
        _searchIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ic ／ Arrows ／ icon_search"]];
    }
    return _searchIV;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        _textField.placeholder = @"请输入场站名称";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

@end
