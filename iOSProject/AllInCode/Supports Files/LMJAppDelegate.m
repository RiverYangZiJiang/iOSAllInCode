//
//  LMJAppDelegate.m
//  PLMMPRJK
//
//  Created by NJHu on 2017/3/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJAppDelegate.h"
#import "LMJTabBarController.h"
#import "LMJIntroductoryPagesHelper.h"
#import "AdvertiseHelper.h"
#import "YYFPSLabel.h"
#import "LMJUMengHelper.h"
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "YZJTabBarController.h"
#import "AvoidCrash.h"

@implementation LMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];  // 一定要有这句，否则屏幕一片漆黑
//    self.window.rootViewController = [[YZJTabBarController alloc] init];
//    [self.window makeKeyAndVisible];
    
    // 如果删除Main.storyboard，在此不添加任何代码，则App也能运行，只不过一片黑，什么都没有。使用Debug View Hierarchy也看不到任务UIWindow、UIView
    
    
    // window在后面有一个get方法
//    self.window.rootViewController = [[LMJTabBarController alloc] init];
    self.window.rootViewController = [[YZJTabBarController alloc] init];
    
    // 刷新率
    [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    
    return YES;
    // 欢迎视图
    [LMJIntroductoryPagesHelper showIntroductoryPageView:@[@"intro_0.jpg", @"intro_1.jpg", @"intro_2.jpg", @"intro_3.jpg"]];
    
    NSArray <NSString *> *imagesURLS = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189872684&di=03f9df0b71bb536223236235515cf227&imgtype=0&src=http%3A%2F%2Fatt1.dzwww.com%2Fforum%2F201405%2F29%2F1033545qqmieznviecgdmm.gif", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189851096&di=224fad7f17468c2cc080221dd78a4abf&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201505%2F12%2F20150512124019_GPjEJ.gif"];
    // 启动广告
    [AdvertiseHelper showAdvertiserView:imagesURLS];
    
    // 检查版本更新
    NSLog(@"%zd", [LMJRequestManager sharedManager].reachabilityManager.networkReachabilityStatus);
    
    // 友盟统计
    [LMJUMengHelper UMAnalyticStart];
    // 友盟社交化
    [LMJUMengHelper UMSocialStart];
    // 友盟推送
    [LMJUMengHelper UMPushStart:launchOptions];
    
    if (launchOptions) {
        [UIAlertController mj_showAlertWithTitle:@"有launchOptions!!" message:launchOptions.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.addActionCancelTitle(@"cancel").addActionDestructiveTitle(@"按钮1");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        }];
    }
    
    
    [AvoidCrash becomeEffective];
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];

    return YES;
}



#pragma mark -应用跳转
//Universal link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    if (userActivity.webpageURL) {
        NSLog(@"%@", userActivity.webpageURL);
        [UIAlertController mj_showAlertWithTitle:@"web跳转应用" message:userActivity.webpageURL.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.addActionDefaultTitle(@"确认");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
        }];
    }
    
    return YES;
}

//iOS9+scheme跳转
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    if (url) {
        NSLog(@"%@", url);
        [UIAlertController mj_showAlertWithTitle:@"iOS9+scheme跳转应用" message:url.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.addActionDefaultTitle(@"确认");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
        }];
    }
    
    return result;
}

// 支持所有iOS9以下系统,scheme 跳转
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
    if (!result) {
        // 其他如支付等SDK的回调   
    }
    if (url) {
        NSLog(@"%@", url);
        [UIAlertController mj_showAlertWithTitle:@"iOS9以下系统scheme跳转应用" message:url.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.addActionDefaultTitle(@"确认");
        } actionsBlock:nil];
        
    }
    
    return result;
}


#pragma mark - deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * string = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                         stringByReplacingOccurrencesOfString: @">" withString: @""]
                        stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"%@", string);
    
    [UIAlertController mj_showAlertWithTitle:@"get deviceToken" message:string appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {

        alertMaker.addActionDefaultTitle(@"确认");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
    }];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"注册远程通知失败: %@", error);
}


#pragma mark - 后台保活
- (void)applicationWillResignActive:(UIApplication *)application {
    [self startBgTask];
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    // 注：安装官方文档：不要在applicationDidEnterBackground: 方法末尾调用本方法并且期望应用能够继续运行，放在applicationWillResignActive调用才能真正实现后台保活
//    [self startBgTask];
}

/// 请求进入后台保活180秒
- (void)startBgTask{
    UIApplication *application = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        //这里延迟的系统时间结束
        NSLog(@"%f",application.backgroundTimeRemaining);
        [application endBackgroundTask:bgTask];
    }];
}


#pragma mark - 通知
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于前台时的远程推送接受
            //关闭U-Push自带的弹出框
            [UMessage setAutoAlert:NO];
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            
            [UIAlertController mj_showAlertWithTitle:@"2_iOS10新增：处理前台收到通知的代理方法" message:userInfo.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.addActionDefaultTitle(@"确认");
            } actionsBlock:nil];
            
        }else{
            //应用处于前台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [UIAlertController mj_showAlertWithTitle:@"3_iOS10新增：处理后台点击通知的代理方法" message:userInfo.description appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.addActionDefaultTitle(@"确认");
        } actionsBlock:nil];
    }else{
        //应用处于后台时的本地推送接受
    }
}

#pragma mark - AvoidCrash
- (void)dealwithCrashMessage:(NSNotification *)note {
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"%@",note.userInfo);
}

#pragma mark - getter
- (UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor RandomColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

@end

