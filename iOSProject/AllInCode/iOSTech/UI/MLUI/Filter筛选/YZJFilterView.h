//
//  YZJFilterView.h
//  AllInCode
//
//  Created by hd on 2021/3/25.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YZJFilterView : UIView
/// 标题，如3月4日
@property (nonatomic, strong) UILabel *titleLabel;

/// <#注释#>
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) void(^viewTappedBlock)(YZJFilterView *view);

- (instancetype)initWitiTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
