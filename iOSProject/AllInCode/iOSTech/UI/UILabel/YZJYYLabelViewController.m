//
//  YZJYYLabelViewController.m
//  AllInCode
//
//  Created by hd on 2021/7/8.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJYYLabelViewController.h"

@interface YZJYYLabelViewController ()
/// 显示“已阅读并同意《用户使用协议》和《个人信息授权协议》”，点击《》跳转到打开协议的界面
@property (nonatomic, strong) YYLabel *protocolLabel;
@end

@implementation YZJYYLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.protocolLabel];
    [self.protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
    }];
}

-(YYLabel *)protocolLabel{
    if (!_protocolLabel) {
        NSString *originText = @"已阅读并同意《用户使用协议》和《个人信息授权协议》";
        NSMutableAttributedString  *text1 = [[NSMutableAttributedString alloc] initWithString:originText];
        text1.yy_font = [UIFont systemFontOfSize:12];
        text1.yy_alignment = NSTextAlignmentLeft;
        text1.yy_color = [UIColor colorWithHexString:@"#626B7A"];
        [text1 yy_setColor:[UIColor colorWithHexString:@"#056FFB"] range:[originText rangeOfString:@"《用户使用协议》"]];
        
        [text1 yy_setTextHighlightRange:[originText rangeOfString:@"《用户使用协议》"]//设置点击的位置
                                  color:[UIColor colorWithHexString:@"#056FFB"]
                        backgroundColor:[UIColor groupTableViewBackgroundColor]
                              tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect)
         {
             NSLog(@"这里是点击事件");
         }];
        [text1 yy_setColor:[UIColor colorWithHexString:@"#056FFB"] range:[originText rangeOfString:@"《个人信息授权协议》"]];
        
        [text1 yy_setTextHighlightRange:[originText rangeOfString:@"《个人信息授权协议》"]//设置点击的位置
                                  color:[UIColor colorWithHexString:@"#056FFB"]
                        backgroundColor:[UIColor groupTableViewBackgroundColor]
                              tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect)
         {
             NSLog(@"这里是点击事件");
         }];
        YYLabel *titleLb                         = [[YYLabel alloc] init];
        titleLb.userInteractionEnabled  = YES;
        titleLb.numberOfLines           = 2;
        titleLb.attributedText = text1;
        titleLb.textVerticalAlignment   = YYTextVerticalAlignmentCenter;
        titleLb.backgroundColor = [UIColor clearColor];
        _protocolLabel = titleLb;
    }
    return _protocolLabel;
}
@end
