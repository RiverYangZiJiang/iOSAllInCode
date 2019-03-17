//
//  UILabel+MLCategory.h
//  iosTest2017
//
//  Created by 杨子江 on 1/20/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (MLCategory)
/**
 创建UILabel

 @param text <#text description#>
 @param font <#font description#>
 @param textColor <#textColor description#>
 @param textAlignment <#textAlignment description#>
 @return <#return value description#>
 */
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSUInteger)numberOfLines;

/**
 单行UILabel的宽度，UILabel的mode默认为NSLineBreakByCharWrapping

 @return 宽度
 */
- (CGFloat)widthForSingleLine;

/**
 UILabel的高度

 @param width UILabel的宽度限制
 @return 高度，UILabel的mode默认为NSLineBreakByCharWrapping
 */
- (CGFloat)heightForWidth:(CGFloat)width;



/**
 参考文献：(2) iOS开发之UI处理-UILabel篇 1.https://www.cnblogs.com/wangwei123/p/3486047.html 
 2.iOS常用控件封装-SZKLabel（基于UILabel的封装）https://www.jianshu.com/p/13fb34fa5f74
 */
@end

NS_ASSUME_NONNULL_END
