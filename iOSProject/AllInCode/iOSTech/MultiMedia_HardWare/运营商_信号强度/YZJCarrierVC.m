//
//  YZJCarrierVC.m
//  AllInCode
//
//  Created by yangzijiang on 2019/4/15.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJCarrierVC.h"

@interface YZJCarrierVC ()

@end

@implementation YZJCarrierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 3: 强 ，2：中， 1：弱 ，无
/// https://www.jianshu.com/p/c53babc583e5  https://blog.csdn.net/weixin_34062469/article/details/86882323 https://www.jianshu.com/p/a5bcdbdbfbf8
// iOS：关于获取网络类型和运营商信息 https://www.cnblogs.com/wudan7/p/3587889.html
-(int)getSignalStrength{
    
    UIApplication *app =[UIApplication sharedApplication];
    
    // iphoneX状态栏和其他iPhone设备不同，变化比较大
    
    //判断是否是iPhoneX
    if([[app valueForKeyPath:@"_statusBar"] isKindOfClass:
        NSClassFromString(@"UIStatusBar_Modern")]){
        
        NSString *wifiEntry =[[[
                                [app valueForKey:@"statusBar"]
                                valueForKey:@"_statusBar"]
                               valueForKey:@"_currentAggregatedData"]
                              //                              valueForKey:@"_wifiEntry"];
                              valueForKey:@"_cellularEntry"];
        // 信号强度和是否打开打开移动网络无关
        int displayValue = [[wifiEntry valueForKey:@"_displayValue"] intValue];
        int displayRawValue = [[wifiEntry valueForKey:@"_displayRawValue"] intValue];
        int isEnabled = [[wifiEntry valueForKey:@"isEnabled"] intValue];
        NSLog(@"displayValue = %d, displayRawValue = %d, isEnabled %d", displayValue, displayRawValue, isEnabled);
        
        return displayValue;
        
    }
    else{
        
        NSArray *subviews =[[[app valueForKey:@"statusBar"]
                             valueForKey:@"foregroundView"]subviews];
        
        NSString *dataNetworkItemView = nil;
        
        for(id subview in subviews){
            // WiFi：UIStatusBarDataNetworkItemView  移动信号：UIStatusBarSignalStrengthItemView
            if([subview isKindOfClass:
                //                [NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]){
                [NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]){
                // 如果不插SIM卡，则为nil
                dataNetworkItemView = subview;
                
                break;
                
            }
            
        }
        // WiFi
        //        int signalStrength =[[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
        
        // 移动信号
        int signalStrengthRaw =[[dataNetworkItemView valueForKey:@"_signalStrengthRaw"] intValue];  // 不管是否插SIM卡都为0
        int signalStrength =[[dataNetworkItemView valueForKey:@"_signalStrengthBars"] intValue];  // 插上SIM卡，信号满格为4；不插SIM卡，为0
        NSLog(@"signalStrengthRaw = %d, signalStrength = %d", signalStrengthRaw, signalStrength);
        
        return signalStrength;
        
    }
    
}

@end
