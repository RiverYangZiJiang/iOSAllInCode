//
//  CustomTableViewCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/4/17.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell


/**
 如果不使用xib，则不会调用本方法
 */
- (void)awakeFromNib {
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
    
    [super awakeFromNib];
    // Initialization code
}


/**
 dequeueReusableCellWithIdentifier会调用本方法，不会调用init方法

 @param style <#style description#>
 @param reuseIdentifier <#reuseIdentifier description#>
 @return <#return value description#>
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
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

@end
