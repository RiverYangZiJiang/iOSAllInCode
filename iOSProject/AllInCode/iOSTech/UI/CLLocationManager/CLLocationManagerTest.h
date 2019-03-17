//
//  CLLocationManagerTest.h
//  OCTest
//
//  Created by yangzijiang on 2018/6/14.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLocationManagerTest : NSObject
+ (instancetype)defaultInstance;

/**
 1.判断GPS坐标是否在中国 https://blog.csdn.net/rongge2008/article/details/50549940?utm_source=blogxgwz0
 2.离线仍然可以获取到经纬度，但是具体位置名称获取不到
 3.设置应用允许访问位置信息的值为“永不”，则获取位置信息会失败，会满足[CLLocationManager authorizationStatus] < kCLAuthorizationStatusAuthorizedAlways
 */
@end
