//
//  UIButton+CPRedPointExtension.h
//  ChargePlatform
//
//  Created by 周明 on 2020/9/3.
//  Copyright © 2020 EverGrande. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CPRedPointExtension)

- (void)setPointOrign:(CGPoint )point;
- (void)cp_showRedPoint:(BOOL)showOrHide;

@end

NS_ASSUME_NONNULL_END
