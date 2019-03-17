//
//  MLAnnotationView.h
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/24.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import <MapKit/MapKit.h>
#import "MLAnnotation.h"

@interface MLAnnotationView : MKAnnotationView

/**
 注：不能取名为annotation，这会和MKAnnotationView的冲突，导致view显示不出来
 */
@property (nonatomic, strong) MLAnnotation *anno;

@end
