//
//  YZJUIViewAnimationVC.h
//  AllInCode
//
//  Created by hd on 2021/2/18.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "LMJStaticTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

/// UIView相关动画，参考文献1.iOS动画-从UIView动画说起；2.动画:UIViewAnimationOptions类型
/*
 1.常规动画属性设置（可以同时选择多个进行设置）
 2.动画速度控制（可从其中选择一个设置）时间函数曲线相关**时间曲线函数**
 UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
 EaseIn ：动画逐渐变慢；EaseOut：动画逐渐加速；Linear ：动画匀速执行，默认值。
 3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）**转场动画相关的**
 UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。[1]

 补充：关于最后一组转场动画它一般是用在这个方法中的：
　　　　[UIView transitionFromView: toView: duration: options:  completion:^(****BOOL****finished) {}];
该方法效果是插入一面视图移除一面视图，期间可以使用一些转场动画效果。
 */
@interface YZJUIViewAnimationVC : LMJStaticTableViewController

@end

NS_ASSUME_NONNULL_END
