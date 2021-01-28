//
//  YZJLeftRightAlignment.m
//  AllInCode
//
//  Created by hd on 2021/1/15.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJLeftRightAlignment.h"

@interface YZJLeftRightAlignment ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation YZJLeftRightAlignment

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(100, 100, 100, 40);
    [self.titleLabel changeAlignmentRightandLeft];
}

- (UILabel *)titleLabel{
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"123" font:[UIFont systemFontOfSize:20] textColor:[UIColor redColor] textAlignment:NSTextAlignmentJustified numberOfLines:1];
    }
    return _titleLabel;
}
@end
