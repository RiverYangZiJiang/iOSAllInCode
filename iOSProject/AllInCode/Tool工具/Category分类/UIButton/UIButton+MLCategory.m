//
//  UIButton+MLCategory.m
//  iosTest2017
//
//  Created by 杨子江 on 1/20/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UIButton+MLCategory.h"
#import "UIView+GestureCallback.h"

@implementation UIButton (MLCategory)

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont{
    return [[UIButton alloc] initWithTitle:title titleColor:titleColor titleFont:titleFont doneBlock:nil];
}

- (UIButton *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont doneBlock:(nullable void(^)(UIButton *))doneBlock{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    self.titleLabel.font = titleFont;
    
    LMJWeak(self);
    [self addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        !doneBlock ?: doneBlock(weakself);
    }];
    
    return self;
}
@end
