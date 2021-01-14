//
//  YZJCountdownLabel.h
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YZJCountdownLabelDelegate <NSObject>

- (void)countDownDone;

@end

/// 具有倒计时功能的label
@interface YZJCountdownLabel : UILabel

/// 初始化倒计时label
/// @param seconds 倒计时的秒数
/// @param delegate 代理
- (instancetype)initWithSeconds:(NSUInteger)seconds delegate:(id<YZJCountdownLabelDelegate>)delegate;

- (void)releaseTimer;

@property (nonatomic, weak) id<YZJCountdownLabelDelegate> countdownLabelDelegate;

@end

NS_ASSUME_NONNULL_END
