//
//  MLCustomSegmentedControlItemView.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/10.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLCustomSegmentedControlItemView.h"
#import <Masonry/Masonry.h>

@interface MLCustomSegmentedControlItemView()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *lineView;
@end
@implementation MLCustomSegmentedControlItemView

- (instancetype)initWithTitle:(NSString *)title index:(NSInteger)idnex isSelected:(BOOL)isSelected
{
    self = [super init];
    if (self) {
        self.title = title;
        self.index = idnex;
        self.isSelected = isSelected;
        
        self.titleLabel.text = self.title;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(10.5);
            make.height.equalTo(@27);
        }];
        
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@45);
            make.height.equalTo(@2);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-4);
        }];
        
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)];
        [self addGestureRecognizer:gr];
    }
    return self;
}

- (void)clicked{
    NSLog(@"%s", __func__);
    if (self.isSelected) {  // 如果原来已经选中，则直接返回
        return;
    }
    self.isSelected = !self.isSelected;
    
    if ([self.delegate respondsToSelector:@selector(MLCustomSegmentedControlItemViewClicked:)]) {
        [self.delegate MLCustomSegmentedControlItemViewClicked:self];
    }
}

- (void)setIsSelected:(BOOL)isSelected{
    NSLog(@"%s", __func__);
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.lineView.hidden = NO;
    }else{
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.lineView.hidden = YES;
    }
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

@end
