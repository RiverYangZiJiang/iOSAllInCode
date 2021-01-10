//
//  UILabel+CPExtension.m
//  ChargePlatform
//
//  Created by 周明 on 2020/9/2.
//  Copyright © 2020 EverGrande. All rights reserved.
//

#import "UILabel+CPExtension.h"

@implementation UILabel (CPExtension)

- (void)sizeToHeight {
    self.height = [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, 0)].height;
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor textFont:(UIFont *)textFont
{
    return [self labelWithTextColor:textColor backgroundColor:[UIColor clearColor] textFont:textFont textAlignment:NSTextAlignmentLeft nuberOflines:1];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                       textFont:(UIFont *)textFont
                  textAlignment:(NSTextAlignment)alignment
{
    return [self labelWithTextColor:textColor backgroundColor:[UIColor clearColor] textFont:textFont textAlignment:alignment nuberOflines:1];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                backgroundColor:(UIColor *)backgroundColor
                       textFont:(UIFont *)textFont
                  textAlignment:(NSTextAlignment)alignment
                   nuberOflines:(NSInteger)lines
{
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = textColor;
    label.backgroundColor = backgroundColor;
    label.font = textFont;
    label.textAlignment = alignment;
    label.numberOfLines = lines;
    return label;
}

/// 账户余额提示
+ (UILabel *)balanceAlertLabel {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 1;
//
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"账户余额低于5元时将自动结束订单，请确保账户余额充足"attributes: @{NSFontAttributeName: SCFont_12, NSForegroundColorAttributeName: [UIColor colorWithRed:238/255.0 green:149/255.0 blue:3/255.0 alpha:1.0]}];
//
//    label.attributedText = string;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.alpha = 1.0;
    return label;
}

@end
