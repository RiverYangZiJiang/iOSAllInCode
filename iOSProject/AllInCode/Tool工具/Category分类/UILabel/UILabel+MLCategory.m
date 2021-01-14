//
//  UILabel+MLCategory.m
//  iosTest2017
//
//  Created by 杨子江 on 1/20/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UILabel+MLCategory.h"
#import "NSString+YYAdd.h"
#import "objc/Runtime.h"

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

- (NSString *)verticalText{
    // 利用runtime添加属性
    return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText{
    objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2-1];
    }
    self.text = str;
    self.numberOfLines = 0;
}
@end
