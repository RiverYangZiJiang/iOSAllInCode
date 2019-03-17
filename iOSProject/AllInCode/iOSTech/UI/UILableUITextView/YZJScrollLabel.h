//
//  YZJScrollLabel.h
//  iosTest2017
//
//  Created by yangzijiang on 2018/4/27.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义可以左右滑动的Label
 
 参考自：http://blog.sina.com.cn/s/blog_6e13eee70100v3g3.html
 */
@interface YZJScrollLabel : UIView

@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) UIScrollView *scrollView;

/**
 初始化
 
 @param frame 如果使用Masonry，那么本参数可以设置为CGRectMake(0, 0, 0, 0)。若没有效果，调用setNeedsLayout方法试试
 @param text label要显示的文本
 @param font label的字体
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font;

@end
