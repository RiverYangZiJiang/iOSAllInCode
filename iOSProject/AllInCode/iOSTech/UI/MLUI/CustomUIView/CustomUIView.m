//
//  CustomUIView.m
//  CustomUIView
//
//  Created by yangzijiang on 29/12/2017.
//  Copyright © 2017 yangzijiang. All rights reserved.
//

#import "CustomUIView.h"

@interface CustomUIView()

@property (nonatomic, assign) int curX;
@property (nonatomic, assign) int curY;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *phoneLabel;

@end
@implementation CustomUIView

// 创建UI控件时会调用该方法执行初始化，可以在本方法中往本控件添加子视图、初始化子视图等操作
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
        self.nameLabel.textColor = [UIColor greenColor];
        self.nameLabel.text = @"yzj";
        [self addSubview:self.nameLabel];
    }
    
    return self;
}

// 如果程序需要自行在该控件上绘制内容(使用CGContextRef获取绘图上下文，如在本控件上画圆、画线等)，则可通过重写该方法来实现
//
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
    // Drawing code
    // 获取绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置填充颜色
    CGContextSetFillColorWithColor(ctx, [[UIColor blueColor] CGColor]);
    // 在本视图上画一个圆
//    CGContextFillEllipseInRect(ctx, CGRectMake(0, 0, 10, 10));
    
    // 以触碰点为圆心，在本视图上绘制一个圆形，绘制的圆不会消失
    CGContextFillEllipseInRect(ctx, CGRectMake(self.curX - 10, self.curY - 10, 10, 10));
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    
    // 添加号码子视图
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 50, 30)];
    self.phoneLabel.textColor = [UIColor greenColor];
    self.phoneLabel.text = @"123456789";
    [self addSubview:self.phoneLabel];
}


/**
 绘制跟随手指运动的小球

 @param touches <#touches description#>
 @param event <#event description#>
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 获取触碰事件UITouch事件
    UITouch *touch = [touches anyObject];
    // 得到触碰时间在当前组件上的触碰点
    CGPoint lastTouch = [touch locationInView:self];
    // 获取触碰点坐标
    self.curX = lastTouch.x;
    self.curY = lastTouch.y;
    
    // 通知该组件重绘
    [self setNeedsDisplay];
}


@end
