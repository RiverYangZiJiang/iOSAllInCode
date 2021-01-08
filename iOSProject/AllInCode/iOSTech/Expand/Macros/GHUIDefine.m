//
//  GHUIDefine.m
//  GHUIKit
//
//  Created by zhtg on 2018/10/24.
//  Copyright © 2018 evergrande. All rights reserved.
//

#import "GHUIDefine.h"

CGFloat viewSafeTopForViewController(UIViewController *viewController) {
    if (@available(iOS 11.0, *)) {
        UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        if ([viewController isKindOfClass:[UIViewController class]]) {
            view = viewController.view;
        }
        return view.safeAreaLayoutGuide.layoutFrame.origin.y;
    } else {
        if ([viewController isKindOfClass:[UIViewController class]]) {
            return viewController.topLayoutGuide.length;
        } else {
            return SC_STATUS_BAR_HEIGHT + 44.0;
        }
    }
}

CGFloat viewSafeBottomForViewController(UIViewController *viewController) {
    if (@available(iOS 11.0, *)) {
        UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        if ([viewController isKindOfClass:[UIViewController class]]) {
            view = viewController.view;
        }
        CGRect layoutFrame = view.safeAreaLayoutGuide.layoutFrame;
        return CGRectGetMaxY(layoutFrame);
    } else {
        if ([viewController isKindOfClass:[UIViewController class]]) {
            return viewController.view.frame.size.height - viewController.bottomLayoutGuide.length;
        } else {
            UIView *view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
            UITabBarController *root = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            if ([root isKindOfClass:[UITabBarController class]]) {
                return view.frame.size.height - root.tabBar.frame.size.height;
            } else {
                return view.frame.size.height;
            }
        }
    }
}

BOOL isIphoneX() {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        // 获取底部安全区域高度，iPhone X 竖屏下为 34.0，横屏下为 21.0，其他类型设备都为 0
        CGFloat bottomSafeInset = keyWindow.safeAreaInsets.bottom;
        if (bottomSafeInset > 0) {
            return YES;
        }
    }
    return NO;
}
