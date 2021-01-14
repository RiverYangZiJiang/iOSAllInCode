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
@end

NS_ASSUME_NONNULL_END
