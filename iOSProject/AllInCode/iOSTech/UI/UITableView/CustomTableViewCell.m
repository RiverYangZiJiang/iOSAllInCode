//
//  CustomTableViewCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/4/17.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "UILabel+CPExtension.h"

@implementation CustomTableViewCell


/**
 如果不使用xib，则不会调用本方法
 */
- (void)awakeFromNib {
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
    
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - LifeCycle
+ (CustomTableViewCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"CustomTableViewCell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descLabel];
        
        /// cell的init方法之后并不会主动调用updateConstraints，要调用以下方法才会调用
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }
    return self;
}
/**
 dequeueReusableCellWithIdentifier会调用本方法，不会调用init方法

 @param style <#style description#>
 @param reuseIdentifier <#reuseIdentifier description#>
 @return <#return value description#>
 */
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//    }
//    return self;
//}

- (void)updateConstraints {
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        // Masonry实现cell自适应高度，要设置cell里最上方控件与cell.contentView上方的距离，最下方控件与cell.contentView下方的距离，各控件间距离
        make.top.equalTo(self.contentView).offset(12);
        // 设置height会报错
//        make.height.mas_equalTo(20);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        // Masonry实现cell自适应高度，要设置cell里最上方控件与cell.contentView上方的距离，最下方控件与cell.contentView下方的距离，各控件间距离
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
    }];
    
    [super updateConstraints];
}

- (instancetype)init
{
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)handleGesture:(UIGestureRecognizer *)recognizer{
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
    [self setEditing:NO animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titleLabel{
    if(!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#0E1F33"] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:1];
        _titleLabel.text = @"测";
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if(!_descLabel) {
        _descLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#0E1F33"] backgroundColor:[UIColor clearColor] textFont:[UIFont PingFangSC_RegularOfSize:14] textAlignment:NSTextAlignmentLeft nuberOflines:0];
        _descLabel.text = @"测";
    }
    return _descLabel;
}
@end
