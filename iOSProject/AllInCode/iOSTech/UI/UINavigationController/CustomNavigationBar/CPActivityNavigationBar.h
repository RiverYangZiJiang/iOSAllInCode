//
//  CPActivityNavigationBar.h
//  AllInCode
//
//  Created by 杨子江 on 1/8/21.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPActivityNavigationBar : UIView
- (instancetype)initWithTitle:(NSString *)title doneBlock:(void(^)(UIButton *button))doneBlock;

@property (copy, nonatomic) void(^doneBlock)(UIButton *button);


@end

NS_ASSUME_NONNULL_END
