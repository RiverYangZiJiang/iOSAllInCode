//
//  MLAnnotation.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/24.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "MLAnnotation.h"

@implementation MLAnnotation
+ (MLAnnotation *)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate color:(UIColor *)color total:(NSUInteger)total{
    MLAnnotation *anno = [[MLAnnotation alloc] init];
    anno.coordinate = coordinate;
    anno.color = color;
    anno.total = total;
    return anno;
}
@end
