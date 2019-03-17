//
//  UIAppearanceTest.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/25.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "UIAppearanceTest.h"
#import <UIKit/UIKit.h>

@implementation UIAppearanceTest
+ (void)setupNNavigationBarAppearance{
    NSLog(@"%s", __func__);
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.barTintColor = [UIColor lightGrayColor];
    appearance.translucent = NO;
    
    /*
     The back indicator image is shown beside the back button.
     The back indicator transition mask image is used as a mask for content during push and pop transitions
     Note: These properties must both be set if you want to customize the back indicator image.
     */
    
//    UIImage *image = [UIImage imageNamed:@"arror"];
    UIImage *image = [UIImage imageNamed:@"back"];  // 图片尺寸太大，会导致显示为n一片蓝色的取悦
    appearance.backIndicatorImage = image;
    appearance.backIndicatorTransitionMaskImage = image;
    appearance.shadowImage = [UIImage new];
//    appearance.titleTextAttributes
}
@end
