//
//  MLCustomSegmentedControlItemView.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/10.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MLCustomSegmentedControlItemView;
@protocol MLCustomSegmentedControlItemViewDelegate <NSObject>

- (void)MLCustomSegmentedControlItemViewClicked:(MLCustomSegmentedControlItemView *)view;

@end

/**
 自定义SegmentedControl里面的ItemView
 */
@interface MLCustomSegmentedControlItemView : UIView
/// 标题
@property (copy, nonatomic) NSString *title;
/// 序号
@property (assign, nonatomic) NSInteger index;
/// 是否已选中
@property (assign, nonatomic) BOOL isSelected;

@property (assign, nonatomic) id<MLCustomSegmentedControlItemViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title index:(NSInteger)idnex isSelected:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
