//
//  MLAnnotationView.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/24.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "MLAnnotationView.h"
#import <Masonry/Masonry.h>
@interface MLAnnotationView ()
@property (nonatomic, strong) NSCache *imageCache;
+ (NSCache *)sharedCache;

@property (nonatomic,strong) UILabel *totalLabel;

@end
@implementation MLAnnotationView
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.totalLabel];
        // 默认值为NO，必须要手动设置为YES
        self.canShowCallout = YES;
        
    }
    NSLog(@"%s, self.frame = %@", __func__, NSStringFromCGRect(self.frame));
    return self;
}

/**
 * Singleton to handle caching of images
 *
 * @version $Revision: 0.1
 */
+ (NSCache *)sharedCache {
    static dispatch_once_t pred = 0;
    static NSCache  *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[NSCache alloc] init];
    });
    return _sharedObject;
}

/**
 * Set the annotation color
 *
 * @version $Revision: 0.1
 */
- (void)setAnno:(MLAnnotation *)anno{
    NSLog(@"%s", __func__);
    _anno = anno;
    self.image = [self annotationWithColor:anno.color text:[NSString stringWithFormat:@"%ld", anno.total]];
    NSLog(@"%s anno.type = %lu", __func__, (unsigned long)((MLAnnotation *)anno).type);
    
    if (self.anno.type == MLAnnotationTypeDefault) {
        self.totalLabel.text = @"";
        return;
    }
    
    // MLAnnotationTypeNumber类型
    self.totalLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)anno.total];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(5);
        make.height.equalTo(@14);
    }];

}

/**
 * Draw the pin
 *
 * @version $Revision: 0.1
 */
- (UIImage *)annotationWithColor:(UIColor *)color text:(NSString *)text {
    // Color String
    CGColorRef colorRef = color.CGColor;
    NSString *colorString = [[CIColor colorWithCGColor:colorRef].stringRepresentation stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *typeName = @"";
    if (self.anno.type == MLAnnotationTypeDefault) {
        typeName = @"_default";
    } else if (self.anno.type == MLAnnotationTypeNumber) {
        typeName = @"_number";
    }
    
    if (!self.imageCache) self.imageCache = [MLAnnotationView sharedCache];
    colorString = [colorString stringByAppendingString:typeName];
    
    if ([self.imageCache objectForKey:colorString]) {
        return [self.imageCache objectForKey:colorString];
    }
    
    CGRect bounds;
    if (self.anno.type == MLAnnotationTypeNumber) {
        bounds = CGRectMake(0, 0, 24, 24);
    }else if(self.anno.type == MLAnnotationTypeDefault){
        bounds = CGRectMake(0, 0, 8, 8);
    }
    
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
    
    [color setStroke]; // 设置绘制颜色
    
    [path stroke]; // 绘制路径
    
    [[UIColor whiteColor] setFill];
    [path fill];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%s, result.size = %@", __func__, NSStringFromCGSize(result.size));

    // Save to cache
    [self.imageCache setObject:result forKey:colorString];
    
    //return the image
    return result;
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
    NSLog(@"%s, result.size = %@", __func__, NSStringFromCGSize(result.size));
    return result;
}

- (UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.textColor = [UIColor blackColor];
        _totalLabel.font = [UIFont systemFontOfSize:12];
    }
    return _totalLabel;
}
@end
