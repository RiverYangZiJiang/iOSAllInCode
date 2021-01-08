//
//  UIFont+GHPingFang.m
//  FCCommon
//
//  Created by zhoutuguang on 2016/12/7.
//  Copyright © 2016年 zhtg. All rights reserved.
//

#import "UIFont+GHPingFang.h"

@implementation UIFont (GHPingFang)

/*
 "PingFangSC-Ultralight",
 "PingFangSC-Regular",
 "PingFangSC-Semibold",
 "PingFangSC-Thin",
 "PingFangSC-Light",
 "PingFangSC-Medium"
 */
+ (BOOL)afterIOS9 {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0;
}


+ (UIFont *)PingFangSC_UltralightFontOfSize:(CGFloat)fontSize {
    if ([self afterIOS9] == NO) {
        return [UIFont systemFontOfSize:fontSize];
    }
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:fontSize];
    return font;
}


+ (UIFont *)PingFangSC_SemiboldFontOfSize:(CGFloat)fontSize {
    if ([self afterIOS9] == NO) {
        return [UIFont systemFontOfSize:fontSize];
    }
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
    return font;
}


+ (UIFont *)PingFangSC_ThinFontOfSize:(CGFloat)fontSize {
    if ([self afterIOS9] == NO) {
        return [UIFont systemFontOfSize:fontSize];
    }
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Thin" size:fontSize];
    return font;
}


+ (UIFont *)PingFangSC_LightFontOfSize:(CGFloat)fontSize {
    if ([self afterIOS9] == NO) {
        return [UIFont systemFontOfSize:fontSize];
    }
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
    return font;
}


+ (UIFont *)PingFangSC_MediumOfSize:(CGFloat)fontSize {
    if ([self afterIOS9] == NO) {
        return [UIFont systemFontOfSize:fontSize];
    }
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    return font;
}


+ (UIFont *)PingFangSC_RegularOfSize:(CGFloat)fontSize {
    if ([self afterIOS9] == NO) {
        return [UIFont systemFontOfSize:fontSize];
    }
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    return font;
}

@end
