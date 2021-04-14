//
//  UIBezierPathView.m
//  AllInCode
//
//  Created by hd on 2021/4/7.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "UIBezierPathView.h"

@implementation UIBezierPathView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    NSLog(@"%s", __func__);
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 画圆
    [path appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 20, 20)]];
    
    // 画线
    [path moveToPoint:CGPointMake(50, 50)];  // 移位到新起点
    [path addLineToPoint:CGPointMake(100, 100)];
//    [[UIColor redColor] setStroke];  // 画线默认为黑色
    [path setLineWidth:2];  // 线宽默认为1.0
    // 4.渲染
    [path stroke];
}


@end
