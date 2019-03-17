//
//  iPhoneXAdaptivityVC.h
//  
//
//  Created by yangzijiang on 2019/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 判断iPhoneX系列
#define isiPhoneXStyle ( (ScreenHeight == 812.f ||  ScreenHeight == 896.f ) ? YES : NO)
#define SafeAreaBottomHeight (isiPhoneXStyle ? 34 : 0)
/**
 1.使用高度SafeAreaBottomHeight
 [self.postACommentsTopView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.right.equalTo(self.commentsView);
 make.bottom.equalTo(self.commentsView).offset(-SafeAreaBottomHeight);
 make.height.equalTo(@48);
 }];
 2.使用mas_safeAreaLayoutGuideBottom[2]
 if (@available(iOS 11.0, *)) {
 make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
 } else {
 make.bottom.mas_equalTo(0);
 }
 3.使用[3]
 MASViewAttribute *top = [self mas_topLayoutGuideBottom];
 MASViewAttribute *bottom = [self mas_bottomLayoutGuideTop];
 #ifdef __IPHONE_11_0
 if (@available(iOS 11.0, *))
 {
 top = [[self view] mas_safeAreaLayoutGuideTop];
 bottom = [[self view] mas_safeAreaLayoutGuideBottom];
 }
 #endif
 [make top].equalTo(top);
 [make bottom].equalTo(bottom);
 
 */


@interface iPhoneXAdaptivityVC : UIViewController

/**
 [1] 34. 适配iOS11，适配iPhoneX，适配安全区的几个文章和宏 https://www.jianshu.com/p/52135c5f144e
 [2] iPhoneX安全区域适配 https://www.jianshu.com/p/89e460edd1c9
 [3]【iOS】论如何优雅的使用安全区来适配iPhone X屏幕 https://www.jianshu.com/p/531fc6ca94f5
 */
@end

NS_ASSUME_NONNULL_END
