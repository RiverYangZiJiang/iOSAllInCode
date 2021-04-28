//
//  LMJAppDelegate.h
//  PLMMPRJK
//
//  Created by NJHu on 2017/3/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface LMJAppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>
/// 注：默认情况下AppDelegate.h没有UIWindow对象，需要手动添加对象并且完成初始化
@property (strong, nonatomic) UIWindow *window;

@end

