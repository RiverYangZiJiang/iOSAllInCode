//
//  UIView+Category.m
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (void)drawCornerWithTopCornerRadius:(CGFloat)topCornerRadius bottomCornerRadius:(CGFloat)bottomCornerRadius {
    
    UIRectCorner corner = UIRectCornerAllCorners;
    CGSize size = CGSizeZero;
    if (topCornerRadius > 0 & bottomCornerRadius > 0) {
        corner = UIRectCornerAllCorners;
        size = CGSizeMake(topCornerRadius, bottomCornerRadius);
    }else if (topCornerRadius > 0) {
        corner = UIRectCornerTopLeft| UIRectCornerTopRight;
        size = CGSizeMake(topCornerRadius, topCornerRadius);
    }else if (bottomCornerRadius > 0) {
        corner = UIRectCornerBottomLeft| UIRectCornerBottomRight;
        size = CGSizeMake(bottomCornerRadius, bottomCornerRadius);
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
