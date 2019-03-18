//
//  MLTopToastView.h
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MLTopToastViewBlock)();

/**
 <#Description#>

 - MLTopToastViewTypeDownloadSuccess: 下载成功
 - MLTopToastViewTypeOffline: 离线
 - MLTopToastViewTypeNetworkUnavailable: 网络不可用
 - MLTopToastViewTypeOpenLocation: 打开位置
 */
typedef NS_ENUM(NSUInteger, MLTopToastViewType) {
    MLTopToastViewTypeDownloadSuccess,
    MLTopToastViewTypeOffline,
    MLTopToastViewTypeNetworkUnavailable,
    MLTopToastViewTypeOpenLocation
};

/**
 显示在顶部的一些提示信息
 */
@interface MLTopToastView : UIView
/**
 创建视图，右边不需要按钮时调用本方法，如MLTopToastViewTypeDownloadSuccess类型

 @param msg 需要显示的信息
 @param type 视图类型
 @param superView 父视图
 @return <#return value description#>
 */
+ (MLTopToastView *)toastViewWithMsg:(NSString *)msg type:(MLTopToastViewType)type superView:(UIView *)superView;

/**
 创建视图，右边需要按钮时调用本方法，如MLTopToastViewTypeOpenLocation类型
 
 @param msg 需要显示的信息
 @param type 视图类型
 @param superView 父视图
 @param buttonTitle 按钮标题
 @param block 点击按钮回调的block
 @return <#return value description#>
 */
+ (MLTopToastView *)toastViewWithMsg:(NSString *)msg type:(MLTopToastViewType)type superView:(UIView *)superView buttonTitle:(NSString * __nullable)buttonTitle block:(MLTopToastViewBlock __nullable)block;

/**
 创建视图
 
 @param msg 需要显示的信息
 @param type 视图类型
 @param superView 父视图
 @param buttonTitle 按钮标题
 @param block 点击按钮回调的block
 @return <#return value description#>
 */
- (instancetype)initWithMsg:(NSString *)msg type:(MLTopToastViewType)type superView:(UIView *)superView buttonTitle:(NSString * __nullable)buttonTitle block:(MLTopToastViewBlock __nullable)block;

/**
 自动显示并且自动隐藏
 */
- (void)autoShowAndHide;

/**
 显示本视图，superView里其他子视图不会下移，而是被覆盖
 */
- (void)show;

/**
 隐藏本视图，和show配对使用
 */
- (void)hide;

/**
 显示本视图，superView里的view视图会下移
 */
- (void)showWithView:(UIView *)view;

/**
 隐藏本视图，和showWithView配对使用
 */
- (void)hideWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
