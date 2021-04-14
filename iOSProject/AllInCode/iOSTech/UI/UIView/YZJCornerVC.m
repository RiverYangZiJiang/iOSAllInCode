//
//  YZJCornerVC.m
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJCornerVC.h"
#import "UIView+Category.h"
#import "UILabel+CPExtension.h"

static CGFloat num;

@interface YZJCornerVC ()
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *titleLabel1;

@property (nonatomic, strong) CAShapeLayer *circle;
@property (nonatomic, strong) CADisplayLink *link;
@end

@implementation YZJCornerVC
@synthesize circle;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleLabel1];
    
    [self bezierCorner];
    [self animationBezierCorner];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.titleLabel.top = 100;
    self.titleLabel.left = 0;
    self.titleLabel.width = self.view.width;
    self.titleLabel.height = 100;
    [self.titleLabel drawCornerWithTopCornerRadius:6 bottomCornerRadius:6];
    
    self.titleLabel1.top = 300;
    self.titleLabel1.left = 20;
    self.titleLabel1.width = self.view.width - 40;
    self.titleLabel1.height = 100;
    [self.titleLabel1 drawCornerWithCornerRadius:4 corner:UIRectCornerTopLeft | UIRectCornerBottomRight];
}

- (UILabel *)titleLabel{
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#A4A9AF"] backgroundColor:[UIColor whiteColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:1];
        _titleLabel.text = @"123";
    }
    return _titleLabel;
}

- (UILabel *)titleLabel1{
    if(!_titleLabel1) {
        _titleLabel1 = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#A4A9AF"] backgroundColor:[UIColor whiteColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:1];
        _titleLabel1.text = @"上左下右圆角";
    }
    return _titleLabel1;
}

/// <#Description#>
- (void)bezierCorner{
    //创建一个蓝色的Layer
    CALayer *foregroundLayer        = [CALayer layer];
    foregroundLayer.bounds          = CGRectMake(0, 0, 100, 100);
    foregroundLayer.backgroundColor = [UIColor redColor].CGColor;
    
    //创建一个路径
    UIBezierPath *apath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 60, 60)];
    
    //创建maskLayer
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = apath.CGPath;
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    
    //设置位置
    foregroundLayer.position = self.view.center;
    //设置mask
    foregroundLayer.mask = maskLayer;
    
    [self.view.layer addSublayer:foregroundLayer];
}

/// 给遮罩层添加动画，定时将新的UIBezierPath对象赋值给path，实现更加绚丽的效果
- (void) animationBezierCorner{
    // 创建一个CAShape
    CALayer *bgLayer = [CALayer layer];
    
    // 设置大小颜色和位置
    bgLayer.bounds          = CGRectMake(0, 0, 200, 200);
    bgLayer.backgroundColor = [UIColor redColor].CGColor;
    bgLayer.position        = self.view.center;
    
    // 创建一个CAShapeLayer作为MaskLayer
    circle = [CAShapeLayer layer];
    
    // 设置路径
    circle.path      = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100)
                                                      radius:20
                                                  startAngle:0
                                                    endAngle:2 * M_PI
                                                   clockwise:YES].CGPath;
    circle.lineWidth = 5;
    circle.fillColor = [UIColor greenColor].CGColor;
    circle.fillRule  = kCAFillRuleEvenOdd;
    
    // 设置maskLayer
    bgLayer.mask = circle;
    
    [self.view.layer addSublayer:bgLayer];
    
    // 添加计时器
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)action {
    
    num ++;
    
    circle.path      = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100)
                                                      radius:20 + num
                                                  startAngle:0
                                                    endAngle:2 * M_PI
                                                   clockwise:YES].CGPath;
    
    if (num > 1000) {
        [self.link invalidate];
    }
}
// 参考文献 1.CALayer之mask属性-遮罩
@end
