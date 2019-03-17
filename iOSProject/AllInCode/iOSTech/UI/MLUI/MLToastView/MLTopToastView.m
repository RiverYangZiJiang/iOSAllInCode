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
@end
@implementation MLTopToastView

+ (MLTopToastView *)successToastViewWithMsg:(NSString *)msg type:(MLTopToastViewType)type{
    return [[MLTopToastView alloc] initWithMsg:msg type:type];
}

- (instancetype)initWithMsg:(NSString *)msg type:(MLTopToastViewType)type
{
    self = [super init];
    if (self) {
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
            default:
                break;
        }
        self.backgroundColor = backgroundColor;
        self.imageView.image = IMAGE_BY_NAME(imgName);
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@24);
        }];
        
        self.msgLabel.text = msg;
        [self addSubview:self.msgLabel];
        [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).offset(12);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
        }];
    }
    return self;
}

#pragma mark - Public
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
@end
