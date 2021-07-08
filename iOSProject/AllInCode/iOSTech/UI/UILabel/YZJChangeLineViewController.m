//
//  YZJChangeLineViewController.m
//  AllInCode
//
//  Created by hd on 2021/6/18.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJChangeLineViewController.h"
#import "UILabel+CPExtension.h"

@interface YZJChangeLineViewController ()
///
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation YZJChangeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    // 可以不指定高度，高度刚好包住内容
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0);
    }];

}

- (UILabel *)titleLabel{
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#0E1F33"] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:0];
        _titleLabel.text = @"abc\ndefg";  // 换行成功，在xib中换行失败
    }
    return _titleLabel;
}

@end
