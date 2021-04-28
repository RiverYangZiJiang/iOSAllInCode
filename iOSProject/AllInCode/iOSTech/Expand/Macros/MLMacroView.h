//
//  MLMacroView.h
//  Mateline
//
//  Created by sprite on 2018/7/18.
//

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define MainScreen [UIScreen mainScreen]
// 屏幕宽度与360的比例
//#define KWidth (ScreenWidth/360)

// 获取主窗口
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow

// MLMainTabBarController控制器，因为主页为了实现抽屉效果，引入了抽屉控制器MMDrawerController，该控制器的centerViewController为MLMainTabBarController
#define Tab_Bar_View_Controller (((MMDrawerController*)KEY_WINDOW.rootViewController).centerViewController)

#define BACK_TITLE(title) [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil]];
#define BACK_TITLE_DEFAULT BACK_TITLE(@"")

// 常用的固定高度
#define NavigationBar_Height                    44
#define NavigationBarAndStatusBar_Height        (NavigationBar_Height + [UIApplication sharedApplication].statusBarFrame.size.height)
//#define TabBar_height                        49
// 适配刘海屏状态栏高度
#define StatusBar_Height (isiPhoneXStyle ? 44.f : 20.f)
//适配iPhone X Tabbar高度
#define TabBar_height (isiPhoneXStyle ? 83.0 : 49.0)
// 适配iPhone X 导航栏高度
#define Nav_Height (isiPhoneXStyle ? 88.f : 64.f)
// 判断iPhoneX系列
#define isiPhoneXStyle (ScreenHeight > 811.f ? YES : NO)

 #define SafeAreaBottomHeight (isiPhoneXStyle ? 34 : 0)

#define kPersonPlaceHolderImage [UIImage imageNamed:@"defaultHeaderImage"]
