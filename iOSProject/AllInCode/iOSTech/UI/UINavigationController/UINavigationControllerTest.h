//
//  UINavigationControllerTest.h
//  iosTest2017
//
//  Created by yangzijiang on 2018/10/24.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationControllerTest : UIViewController
#pragma mark - iOS 左上角的返回按钮的几种设置
/**
 iOS 左上角的返回按钮的几种设置 https://blog.csdn.net/qq_36905061/article/details/74330643
 只是修改返回按钮的文字显示，设置为空字符串，就不显示文字，这个不会影响作画返回的手势
 self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
 
 
 iOS 自定义导航栏返回按钮
 https://blog.csdn.net/shuai265/article/details/79062998
 
 https://www.jianshu.com/p/43dad6794db4
 leftBarButtonItem是本控制器的返回按钮
 backBarButtonItem是设置A Push到B，B的返回按钮；
 从显示的优先级来讲（假如现在即将从A视图跳到B视图，从B视图角度说）：
 1、如果B视图有一个自定义的左侧按钮（leftBarButtonItem），则会显示这个自定义按钮；
 2、如果B没有自定义按钮，但是A视图的backBarButtonItem属性有自定义项，则显示这个自定义项（依然是一个后退按钮，自定义的部分只有背景或title）；
 3、如果前2条都没有，则默认显示一个后退按钮，后退按钮的标题是A视图的标题。
 
 */
@end

NS_ASSUME_NONNULL_END
