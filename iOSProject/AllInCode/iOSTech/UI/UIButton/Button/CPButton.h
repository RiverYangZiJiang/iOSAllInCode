//
//  CPButton.h
//  extentButtonDemo
//
//  Created by 周明 on 2020/8/21.
//  Copyright © 2020 周明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPButton : UIButton

@property (nonatomic, assign) CGSize hitTestSize;

/**
 创建UIButtonTypeCustom类型按钮

 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param titleFont <#titleFont description#>
 @return <#return value description#>
 */
- (CPButton *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont doneBlock:(void(^)(UIButton *button))doneBlock;

+ (CPButton *)mainButtonWithTitle:(NSString *)title clickedBlock:(void (^)(void))clickedBlock;

/// 创建normal状态为蓝底白字，disable状态为灰底灰字的按钮
+ (CPButton *)blueBGWhiteTextButtonWithTitle:(NSString *)title clickedBlock:(void (^)(void))clickedBlock;

/// 创建normal状态为蓝字灰底蓝色边框按钮
+ (CPButton *)blueTextGrayBGButtonWithTitle:(NSString *)title clickedBlock:(void (^)(void))clickedBlock;

/// 创建只包含图片的按钮，可以设置normal和selected状态对应的图片
/// @param normalImageName <#normalImageName description#>
/// @param selectedImageName <#selectedImageName description#>
/// @param clickedBlock <#clickedBlock description#>
+ (CPButton *)buttonWithNormalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName clickedBlock:(void (^)(void))clickedBlock;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end

