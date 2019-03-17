//
//  UILabel+MLCategory.m
//  iosTest2017
//
//  Created by 杨子江 on 1/20/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UILabel+MLCategory.h"
#import "NSString+YYAdd.h"

@implementation UILabel (MLCategory)
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSUInteger)numberOfLines
{
    UILabel *label = [[UILabel alloc] init];
    if (label) {
        label.text = text;
        label.font = font;
        label.textColor = textColor;
        label.textAlignment = textAlignment;
        label.numberOfLines = numberOfLines;
    }
    return label;
}

- (CGFloat)widthForSingleLine{
    CGSize size = [self.text sizeForFont:self.font size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByCharWrapping];
    return size.width;
}

- (CGFloat)heightForWidth:(CGFloat)width{
    return [self.text heightForFont:self.font width:width];
}
@end
