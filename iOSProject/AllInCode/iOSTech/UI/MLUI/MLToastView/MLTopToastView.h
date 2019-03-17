//
//  MLTopToastView.h
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MLTopToastViewType) {
    MLTopToastViewTypeDownloadSuccess,
    MLTopToastViewTypeOffline,
    MLTopToastViewTypeNetworkUnavailable
};

@interface MLTopToastView : UIView
+ (MLTopToastView *)successToastViewWithMsg:(NSString *)msg type:(MLTopToastViewType)type;

- (instancetype)initWithMsg:(NSString *)msg type:(MLTopToastViewType)type;

+ (CGFloat)heightForMsg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
