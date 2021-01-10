//
//  CPActivityNavigationBar.m
//  AllInCode
//
//  Created by 杨子江 on 1/8/21.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "CPActivityNavigationBar.h"
#import "UILabel+CPExtension.h"
#import "UIFont+GHPingFang.h"

@interface CPActivityNavigationBar ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *leftButton;
@end

@implementation CPActivityNavigationBar

- (instancetype)initWithTitle:(NSString *)title doneBlock:(void(^)(UIButton *button))doneBlock {
    self = [super init];
    if (self) {
        self.doneBlock = doneBlock;
        self.titleLabel.text = title;
        [self addSubview:self.titleLabel];
        [self addSubview:self.leftButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageW = 20;
    CGFloat labelWidth = ceil([self.leftButton.titleLabel.text widthForFont:self.leftButton.titleLabel.font]);
    [self.leftButton sizeToFit];
    self.leftButton.left = 13.5;
    self.leftButton.bottom = self.bottom - 13;
    self.leftButton.width = labelWidth + imageW;
    self.leftButton.height = imageW;
    // 设置文字在左，图片在右，系统默认是图片在左，文字在右
    self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0,labelWidth, 0, -labelWidth);
    self.leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageW, 0, imageW);
    
    self.titleLabel.height = 24;
    self.titleLabel.bottom = self.bottom - 11;
    self.titleLabel.left = 0;
    self.titleLabel.width = self.width;
    
}

- (UILabel *)titleLabel{
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:16] textAlignment:NSTextAlignmentCenter nuberOflines:1];
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectZero buttonTitle:@"深圳" normalBGColor:[UIColor clearColor] selectBGColor:[UIColor clearColor] normalColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] selectColor:[UIColor clearColor] buttonFont:[UIFont PingFangSC_RegularOfSize:14] cornerRadius:0 doneBlock:^(UIButton *button) {
            NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
            if (self.doneBlock) {
                self.doneBlock(button);
            }
//            PERFORM_SAFE_BLOCK(self.doneBlock(button));
        }];
//        _leftButton = [UIButton buttonWithTitle:@"深圳" titleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] titleFont:[UIFont PingFangSC_RegularOfSize:14]];
        [_leftButton setImage:[UIImage imageNamed:@"ic／icon_all_entry"] forState:UIControlStateNormal];
    }


    return _leftButton;
}

@end
