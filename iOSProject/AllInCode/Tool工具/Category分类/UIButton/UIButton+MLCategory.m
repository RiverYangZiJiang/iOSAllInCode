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

/// 设置背景颜色for state
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

// 设置颜色
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
 
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
 
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    return image;
}

@end
