//
//  UIImageTestVC.m
//  iosTest2017
//
//  Created by 杨子江 on 1/20/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UIImageTestVC.h"
#import "YZJUIImageBase64VC.h"

@interface UIImageTestVC ()

@end

@implementation UIImageTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addItem([LMJWordArrowItem itemWithTitle:@"base64" subTitle:nil destVc:@"YZJUIImageBase64VC"]);
    
    self.addItem([LMJWordArrowItem itemWithTitle:@"YYAnimatedImageView" subTitle:nil destVc:@"YZJYYAnimatedImageViewVC"]);
}

#pragma mark - 图片拉伸
- (void)resizableImageTest{
    UIImage *image = [UIImage imageNamed:@""];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(24, 0, 24, 0) resizingMode:UIImageResizingModeStretch];
}

@end
