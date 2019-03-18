//
//  MLTopToastView.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "MLTopToastView.h"
@interface MLTopToastView ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *msgLabel;
@property (strong, nonatomic) UIButton *button;
@property (copy, nonatomic) MLTopToastViewBlock block;
/// 是否已经显示
@property(assign, nonatomic) BOOL hadShown;
@end
@implementation MLTopToastView

+ (MLTopToastView *)toastViewWithMsg:(NSString *)msg type:(MLTopToastViewType)type superView:(UIView *)superView{
    return [[MLTopToastView alloc] initWithMsg:msg type:type superView:superView buttonTitle:nil block:nil];
}

+ (MLTopToastView *)toastViewWithMsg:(NSString *)msg type:(MLTopToastViewType)type superView:(UIView *)superView buttonTitle:(NSString * __nullable)buttonTitle block:(MLTopToastViewBlock __nullable)block{
    return [[MLTopToastView alloc] initWithMsg:msg type:type superView:superView buttonTitle:buttonTitle block:block];
}

- (instancetype)initWithMsg:(NSString *)msg type:(MLTopToastViewType)type superView:(UIView *)superView buttonTitle:(NSString * __nullable)buttonTitle block:(MLTopToastViewBlock __nullable)block
{
    self = [super init];
    if (self) {
        // 设置背景色、图片
        UIColor *backgroundColor;
        NSString *imgName;
        switch (type) {
            case MLTopToastViewTypeDownloadSuccess:
                backgroundColor = color_functional_ceffee;
                imgName = @"ic_wifioff_oval_success";
                break;
            case MLTopToastViewTypeOffline:
                backgroundColor = color_neutral_grey_lighter;
                imgName = @"ic_wifioff_oval";
                break;
            case MLTopToastViewTypeNetworkUnavailable:
                backgroundColor = color_functional_fee7e0;
                imgName = @"ic_wifioff_oval_error";
                break;
            case MLTopToastViewTypeOpenLocation:
                backgroundColor = color_functional_fff4e5;
                imgName = @"ic_location_oval";
                break;
            default:
                break;
        }
        self.backgroundColor = backgroundColor;
        self.imageView.image = IMAGE_BY_NAME(imgName);
        
        // 增加各子视图
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@24);
        }];
        
        self.msgLabel.text = msg;
        [self addSubview:self.msgLabel];
        
        if (type == MLTopToastViewTypeOpenLocation) {  // 需要显示按钮
            [self.button setTitle:buttonTitle forState:UIControlStateNormal];
            self.block = block;
            [self addSubview:self.button];
            CGFloat buttonW = [buttonTitle widthForFont:self.button.titleLabel.font] + 16;
            [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-16);
                make.centerY.equalTo(self);
                make.height.equalTo(@24);
                make.width.equalTo(@(buttonW));
            }];
            
            [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageView.mas_right).offset(12);
                make.right.equalTo(self.button.mas_left).offset(-14);
                make.top.equalTo(self).offset(10);
                make.bottom.equalTo(self).offset(-10);
            }];
        }else{  // 不需要显示按钮
            [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageView.mas_right).offset(12);
                make.right.equalTo(self).offset(-16);
                make.top.equalTo(self).offset(10);
                make.bottom.equalTo(self).offset(-10);
            }];
        }
        
        // 将本视图添加到父视图
        [superView addSubview:self];
        CGFloat toastViewH = [MLTopToastView heightForMsg:msg];
        self.frame = CGRectMake(0, -toastViewH + NavigationBar_Height + StatusBar_Height, kScreenWidth, toastViewH);
    }
    return self;
}

#pragma mark - Public
- (void)autoShowAndHide{
    [UIView animateWithDuration:1 animations:^{
        self.lmj_y += self.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 animations:^{
            self.lmj_y -= self.height;
        }];
    }];
}

- (void)show{
    if (self.hadShown) {
        return;
    }
    
    self.hadShown = YES;
    
    self.lmj_y += self.height;
}

- (void)hide{
    if (!self.hadShown) {
        return;
    }
    
    self.hadShown = NO;
    
    self.lmj_y -= self.height;
}

- (void)showWithView:(UIView *)view{
    if (self.hadShown) {
        return;
    }
    
    self.hadShown = YES;
    
    self.lmj_y += self.height;
    view.lmj_y += self.height;
    view.height -= self.height;
}

- (void)hideWithView:(UIView *)view{
    if (!self.hadShown) {
        return;
    }
    
    self.hadShown = NO;
    
    self.lmj_y -= self.height;
    view.lmj_y -= self.height;
    view.height += self.height;
}

#pragma mark - Selector
- (void)buttonClicked:(UIButton *)button{
    self.block();
}

#pragma mark - Private
+ (CGFloat)heightForMsg:(NSString *)msg{
    CGFloat msgLabelW = kScreenWidth - 52 - 16;
    CGFloat msgLabelH = [msg heightForFont:font_size_caption width:msgLabelW] + 1;
    return 10 + msgLabelH + 10;
}

#pragma mark - Getters & Setters
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_wifioff_oval_success"]];
    }
    return _imageView;
}

- (UILabel *)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [UILabel labelWithText:@"The tool was successfully downloaded and added to My Tools." font:font_size_caption textColor:color_neutral_charcoal_medium textAlignment:NSTextAlignmentLeft numberOfLines:0];
    }
    return _msgLabel;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithTitle:@"TURN ON" titleColor:color_neutral_charcoal_medium titleFont:font_size_caption];
        _button.backgroundColor = color_neutral_white;
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
@end
