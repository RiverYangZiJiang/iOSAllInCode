//
//  MLAnnotation.h
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/24.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
typedef NS_ENUM(NSUInteger, MLAnnotationType) {
    MLAnnotationTypeDefault,
    MLAnnotationTypeNumber
};

@interface MLAnnotation : NSObject<MKAnnotation>
// 控制大头针扎在地图上哪个位置
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// 控制大头针弹框显示的标题
@property (nonatomic, copy, nullable) NSString *title;
// 控制大头针弹框显示的子标题
@property (nonatomic, copy, nullable) NSString *subtitle;

/// The color of the annotation
@property (nonatomic, strong) UIColor *color;

@property (assign, nonatomic) NSUInteger total;

@property (assign, nonatomic) MLAnnotationType type;

/**
 是否被选择，默认为否
 */
@property (assign, nonatomic) BOOL didSelect;

+ (MLAnnotation *)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate color:(UIColor *)color total:(NSUInteger)total;




@end

