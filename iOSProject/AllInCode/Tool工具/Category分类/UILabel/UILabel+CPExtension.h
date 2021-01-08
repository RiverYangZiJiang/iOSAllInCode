//
//  UILabel+CPExtension.h
//  ChargePlatform
//
//  Created by 周明 on 2020/9/2.
//  Copyright © 2020 EverGrande. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CPExtension)

- (void)sizeToHeight;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor textFont:(UIFont *)textFont;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                       textFont:(UIFont *)textFont
                  textAlignment:(NSTextAlignment)alignment;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                backgroundColor:(UIColor *)backgroundColor
                       textFont:(UIFont *)textFont
                  textAlignment:(NSTextAlignment)alignment
                   nuberOflines:(NSInteger)lines;

/// 账户余额提示
+ (UILabel *)balanceAlertLabel;
@end

NS_ASSUME_NONNULL_END
