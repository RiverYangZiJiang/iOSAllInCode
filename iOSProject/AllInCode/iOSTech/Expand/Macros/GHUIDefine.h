//
//  GHUIDefine.h
//  GHUIKit
//
//  Created by zhtg on 2018/10/24.
//  Copyright © 2018 evergrande. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

CGFloat viewSafeTopForViewController(UIViewController *object);
CGFloat viewSafeBottomForViewController(UIViewController * object);
BOOL isIphoneX();

#ifndef GHUIDefine_h
#define GHUIDefine_h

//#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//#   define DLog(...)
//#endif

#define ISIOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define SC_VIEW_VALUE_FLUCTUATE(x) (roundf((x) * [UIScreen mainScreen].scale) / [UIScreen mainScreen].scale) // 对X针对屏幕进行上下浮动，如：1.6，在2倍屏幕上得到的值是1.5，在三倍屏幕上得到的值是1.6666666
#define SC_VIEW_VALUE_ADAPTATION(x,screen,current) ((x) * (screen) / (current))
#define SC_VIEW_VALUE_FLUCTUATE_ADAPTATION(x,screen,current) (SC_VIEW_VALUE_FLUCTUATE(SC_VIEW_VALUE_ADAPTATION(x,screen,current)))
#define SC_VIEW_WIDTH_IN_4_7(x)  (SC_VIEW_VALUE_FLUCTUATE_ADAPTATION(x,[UIScreen mainScreen].bounds.size.width,375.0))
#define SC_VIEW_HEIGHT_IN_4_7(x)  (SC_VIEW_VALUE_FLUCTUATE_ADAPTATION(x,[UIScreen mainScreen].bounds.size.height,667.0))
#define SC_VIEW_HEIGHT_IN_IPHONEX(x)  (SC_VIEW_VALUE_FLUCTUATE_ADAPTATION(x,[UIScreen mainScreen].bounds.size.height,812.0))
#define SC_VIEW_SAFE_TOP (viewSafeTopForViewController(self))
#define SC_VIEW_SAFE_BOTTOM (viewSafeBottomForViewController(self))
#define SC_STATUS_BAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)
#define SC_NAVIGATION_BAR_HEIGHT (SC_STATUS_BAR_HEIGHT + [UIViewController currentViewController].navigationController.navigationBar.frame.size.height)
#define SW(x) (SC_VIEW_WIDTH_IN_4_7(x))
#define SH(x) (SC_VIEW_HEIGHT_IN_IPHONEX(x))
#define SC_IS_IPHONEX (isIphoneX())

#define SC_VIEW_BOTTOM_HEIGHT (self.view.bounds.size.height - SC_VIEW_SAFE_BOTTOM)

// UIColor
#define RGBA(r, g, b, a) ([UIColor colorWithRed:((CGFloat)(r) / 255.0) green:((CGFloat)(g) / 255.0) blue:((CGFloat)(b) / 255.0) alpha:(a)])
#define RGB(r, g, b) (RGBA(r, g, b, 1.0))
#define rgba(r, g, b, a) (RGBA(r, g, b, a))

#define HexRGBA(rgbValue, a) ([UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:(a)])
#define HexRGB(rgbValue) (HexRGBA(rgbValue, 1.0))

#endif
