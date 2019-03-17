//
//  UINavigationControllerTest.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/10/24.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "UINavigationControllerTest.h"
#import <objc/runtime.h>

@interface UINavigationControllerTest ()

@end

@implementation UINavigationControllerTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s", __func__);
}

@end
