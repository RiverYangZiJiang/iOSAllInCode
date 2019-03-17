//
//  MLCustomSegmentedControl.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/10.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MLCustomSegmentedControlItemView;
@protocol MLCustomSegmentedControlDelegate <NSObject>

- (void)MLCustomSegmentedControlItemViewClicked:(NSInteger)index;

@end

/**
 自定义SegmentedControl
 */
@interface MLCustomSegmentedControl : UIView
/// 标题
@property (strong, nonatomic) NSArray *titles;
/// 已选择的index
@property (assign, nonatomic) NSInteger selectedIndex;

@property (assign, nonatomic) id<MLCustomSegmentedControlDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
