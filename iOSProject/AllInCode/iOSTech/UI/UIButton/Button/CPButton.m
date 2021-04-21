//
//  CPButton.m
//  extentButtonDemo
//
//  Created by 周明 on 2020/8/21.
//  Copyright © 2020 周明. All rights reserved.
//

#import "CPButton.h"
#import "UIView+GestureCallback.h"

@implementation CPButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(self.hitTestSize.width == 0 || self.hitTestSize.height == 0){
        return [super pointInside:point withEvent:event];
    }
    CGRect rect = self.bounds;
    rect.origin.x -= (self.hitTestSize.width - self.bounds.size.width)/2;
    rect.origin.y -= (self.hitTestSize.height - self.bounds.size.height)/2;
    rect.size = self.hitTestSize;
    return CGRectContainsPoint(rect, point);
}

- (CPButton *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont doneBlock:(void(^)(UIButton *buttonn))doneBlock{
    self = [CPButton buttonWithType:UIButtonTypeCustom];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    self.titleLabel.font = titleFont;
    
    WeakSelf
    [self addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        !doneBlock ?: doneBlock(weakSelf);
    }];
    
    return self;
}

+ (CPButton *)mainButtonWithTitle:(NSString *)title clickedBlock:(void (^)(void))clickedBlock{
    CPButton *_mainButton = [[CPButton alloc] initWithTitle:title titleColor:[UIColor whiteColor]  titleFont:[UIFont PingFangSC_RegularOfSize:19] doneBlock:^(UIButton *button) {
        if (clickedBlock) {
            clickedBlock();
        }
    }];

    _mainButton.layer.cornerRadius = 24.f;
    _mainButton.layer.masksToBounds = YES;
    _mainButton.titleLabel.font = [UIFont PingFangSC_RegularOfSize:19];
    [_mainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_mainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [_mainButton setBackgroundImage:[UIImage imageNamed:@"common-button-big"] forState:UIControlStateNormal];
    [_mainButton setBackgroundImage:[UIImage imageNamed:@"common-button-big"] forState:UIControlStateSelected];
    [_mainButton setBackgroundImage:[UIImage imageWithColor:CPHexRGB(0xE2E5E8)] forState:UIControlStateDisabled];
    return _mainButton;
}

+ (CPButton *)blueBGWhiteTextButtonWithTitle:(NSString *)title clickedBlock:(void (^)(void))clickedBlock{
    CPButton *button = [[CPButton alloc] initWithTitle:title titleColor:[UIColor whiteColor]  titleFont:[UIFont PingFangSC_RegularOfSize:16] doneBlock:^(UIButton *button) {
        if (clickedBlock) {
            clickedBlock();
        }
    }];

    [button setTitleColor:[UIColor colorWithHexString:@"#9FA4AD"] forState:UIControlStateDisabled];
    [button setBackgroundImage:[CPButton imageWithColor:[UIColor colorWithHexString:@"#056FFB"]] forState:UIControlStateNormal];
    [button setBackgroundImage:[CPButton imageWithColor:[UIColor colorWithHexString:@"#ECEDEF"]] forState:UIControlStateDisabled];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 2;
    
    return button;
}

+ (CPButton *)blueTextGrayBGButtonWithTitle:(NSString *)title clickedBlock:(void (^)(void))clickedBlock{
    CPButton *button = [[CPButton alloc] initWithTitle:title titleColor:[UIColor colorWithHexString:@"#056FFB"]  titleFont:[UIFont PingFangSC_RegularOfSize:16] doneBlock:^(UIButton *button) {
        if (clickedBlock) {
            clickedBlock();
        }
    }];

    
    
    button.layer.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0].CGColor;
    button.layer.borderColor = [UIColor colorWithHexString:@"#056FFB"].CGColor;
    button.layer.borderWidth = 0.5;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 2;
    
    return button;
}

/// 创建只包含图片的按钮，可以设置normal和selected状态对应的图片
+ (CPButton *)buttonWithNormalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName clickedBlock:(void (^)(void))clickedBlock{
    CPButton *button = [[CPButton alloc] initWithTitle:nil titleColor:nil  titleFont:nil doneBlock:^(UIButton *button) {
        if (clickedBlock) {
            clickedBlock();
        }
    }];

    [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];

    return button;
}

/// 设置背景颜色for state
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[CPButton imageWithColor:backgroundColor] forState:state];
}

// 设置颜色
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
 
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
 
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    return image;
}


@end
