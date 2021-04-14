//
//  YZJFilterView.m
//  AllInCode
//
//  Created by hd on 2021/3/25.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJFilterView.h"
#import "UILabel+CPExtension.h"

@interface YZJFilterView ()

/// 箭头
@property (nonatomic, strong) UIImageView *arrowIV;
@end

@implementation YZJFilterView

- (instancetype)initWitiTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        [self addSubview:self.titleLabel];
        [self addSubview:self.arrowIV];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterViewTapped:)];
        self.userInteractionEnabled = YES;  // 必须设置才能交互
        [self addGestureRecognizer:gr];
    }
    return self;
}

- (void)updateConstraints {
    [self.arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.arrowIV.mas_left).offset(-2);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(18);
    }];
    
    [super updateConstraints];
}

- (void)filterViewTapped:(UIGestureRecognizer *)gr {
    YZJFilterView *view = (YZJFilterView *)gr.view;
    // 点击箭头倒转
    view.arrowIV.transform = CGAffineTransformRotate(view.arrowIV.transform, M_PI);
    if (self.viewTappedBlock) {
        self.viewTappedBlock(self);
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#222A37"] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:12] textAlignment:NSTextAlignmentRight nuberOflines:1];
        _titleLabel.text = @"3月4日";
    }
    return _titleLabel;
}

- (UIImageView *)arrowIV {
    if (!_arrowIV) {
        _arrowIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic／arrows／icon_card_pull-down"]];
    }
    return _arrowIV;
}
@end
