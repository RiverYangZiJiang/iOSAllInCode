//
//  YZJConcentricCirclesVC.m
//  iOSProject
//
//  Created by yangzijiang on 2018/12/24.
//  Copyright © 2018 github.com/njhu. All rights reserved.
//

#import "YZJConcentricCirclesVC.h"

@interface YZJConcentricCirclesVC ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation YZJConcentricCirclesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 24, 24)];
    self.imageView.image = [self drawImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView.image = [YZJConcentricCirclesVC createImageColor:[UIColor greenColor] size:CGSizeMake(100, 100)];
    [self.view addSubview:self.imageView];
}

- (UIImage *)drawImage{
    CGRect bounds = CGRectMake(0, 0, 24, 24);
    
    // 根据 bounds 计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0.0f);
    // 根据视图宽和高中的较小值计算圆形的半径
    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0) - 1;
    
    UIBezierPath *path = [[UIBezierPath alloc] init]; //创建一个对象
    
    // 以中心为原点，radius 为半径，定义一个 0 到 M_PI * 2.0 弧度的路径（整圆）
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    path.lineWidth = 2; // 设置线条宽度为 10 点
    
    [[UIColor orangeColor] setStroke]; // 设置绘制颜色为橙色
    
    [path stroke]; // 绘制路径
    
    [[UIColor whiteColor] setFill];
    [path fill];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size {
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //绘制颜色区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [color setFill];
    [path fill];
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGContextSetFillColorWithColor(ctx, color.CGColor);
    //    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    //从图形上下文获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
