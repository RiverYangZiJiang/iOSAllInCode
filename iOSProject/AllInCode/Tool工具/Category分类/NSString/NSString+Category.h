//
//  NSString+Category.h
//  OCTest
//
//  Created by yangzijiang on 2018/4/29.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 使用CGSize、CGRect要引入UIKit.h，否则会报“Expected a type”错误

@interface NSString (Category)
/**
 根据指定文本和字体计算尺寸，适用于不换行的情况,宽度不受限制的情况
 
 @param text <#text description#>
 @param font <#font description#>
 @return <#return value description#>
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;

/**
 根据指定文本,字体和最大宽度计算尺寸，适用于换行的情况,同时适用于不换行的情况
 
 @param text <#text description#>
 @param font <#font description#>
 @param width <#width description#>
 @return <#return value description#>
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width;
- (NSUInteger)length;

@end
