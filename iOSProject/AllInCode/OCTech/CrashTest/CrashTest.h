//
//  CrashTest.h
//  OCTest
//
//  Created by yangzijiang on 09/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashTest : NSObject
+ (void)crashTest;

+ (void)arrayCrashTest;
+ (void)avoidCrashTest;
@end

#pragma mark - AvoidCrash
/**
 一个已经发布到AppStore上的App，最忌讳的就是崩溃问题。为什么在开发阶段或者测试阶段都不会崩溃，而发布到AppStore上就崩溃了呢？究其根源，最主要的原因就是数据的错乱。特别是 服务器返回数据的错乱，将严重影响到我们的App。
 或许你会问就算防止了崩溃，但是所获取到的数据变成nil或者并非是你所需要的数据，这又有什么用？对于防止崩溃，我的理解是，宁愿一个功能不能用，都要让app活着，至少其他功能还能用。
 
 Foundation框架存在许多潜在崩溃的危险
 ● 将 nil 插入可变数组中会导致崩溃。
 ● 数组越界会导致崩溃。
 ● 根据key给字典某个元素重新赋值时，若key为 nil 会导致崩溃。
 https://github.com/chenfanfang/AvoidCrash
 
 调用非空对象不存在的方法会崩溃；nil对象调用任何方法都只是返回nil，不会崩溃
 -[NSNull isEqualToString:]: unrecognized selector sent to instance 0x1b63ba878
 
 调用空的block会崩溃
 
 */
