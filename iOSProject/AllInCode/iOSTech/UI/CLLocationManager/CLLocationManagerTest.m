//
//  CLLocationManagerTest.m
//  OCTest
//
//  Created by yangzijiang on 2018/6/14.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "CLLocationManagerTest.h"
#import <CoreLocation/CoreLocation.h>

@interface CLLocationManagerTest()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@end
@implementation CLLocationManagerTest
+ (instancetype)defaultInstance {
    static CLLocationManagerTest *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance startLocation];
    });
    return sharedInstance;
}

/**
 开始定位，模拟器、真机都可以调试
 1.必须在Info.plist设置NSLocationAlwaysAndWhenInUseUsageDescription和NSLocationWhenInUseUsageDescription
 This app has attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain both NSLocationAlwaysAndWhenInUseUsageDescription and NSLocationWhenInUseUsageDescription keys with string values explaining to the user how the app uses this data
 */
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        // 控制定位精度,越高耗电量越；如果设置为kCLLocationAccuracyBest，则每隔一秒钟调用一次didUpdateLocations
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 申请总是授权
        [self.locationManager requestAlwaysAuthorization];
//        self.locationManager.distanceFilter = 10.0f;  // 移动多少米才会调用didUpdateLocations方法
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

/**
 定位代理经纬度回调，每隔一秒钟被调用一次
 
 @param manager <#manager description#>
 @param locations CLLocation数组
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"%s", __func__);
    CLLocation *newLocation = locations[0];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息 http://m.blog.csdn.net/article/details?id=46788567
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
//            NSLog(@"city = %@", city);//石家庄市
//            NSLog(@"--%@",placemark.name);//黄河大道221号
//            NSLog(@"++++%@",placemark.subLocality); //裕华区
//            NSLog(@"country == %@",placemark.country);//中国
//            NSLog(@"administrativeArea == %@",placemark.administrativeArea); //河北省
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
//    [manager stopUpdatingLocation];
    
}

/**
 若在"设置-OCTest-位置"改为"永不"，则会打印"访问被拒绝”日志，不会再弹窗提示是否允许
 
 @param manager <#manager description#>
 @param error <#error description#>
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
@end
