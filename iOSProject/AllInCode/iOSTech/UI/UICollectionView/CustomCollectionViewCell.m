//
//  CustomCollectionViewCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/12/20.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation CustomCollectionViewCell
// 返回cell 的方法好像只能写initWithFrame，不能用init
- (instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"frame = %@", NSStringFromCGRect(frame));
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView{
    [self addSubview:self.titleLabel];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        // 注意cell里面的控件使用的位置是相对于cell的位置，所以使用bounds
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor redColor];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

@end
