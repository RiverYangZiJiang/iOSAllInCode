//
//  UIView+Category.h
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Category)

/// 画圆角
/// @param topCornerRadius 顶部圆角弧度，如果无，则填<=0的值
/// @param bottomCornerRadius 底部圆角弧度，如果无，则填<=0的值
- (void)drawCornerWithTopCornerRadius:(CGFloat)topCornerRadius bottomCornerRadius:(CGFloat)bottomCornerRadius;

/// 画任意角的圆角
/// @param cornerRadius 圆角弧度
/// @param corner 可以使用位运算进行圆角设置，如UIRectCorner corner = UIRectCornerTopRight | UIRectCornerBottomRight; // 右上和右下进行圆角
- (void)drawCornerWithCornerRadius:(CGFloat)cornerRadius corner:(UIRectCorner)corner;
@end

NS_ASSUME_NONNULL_END
