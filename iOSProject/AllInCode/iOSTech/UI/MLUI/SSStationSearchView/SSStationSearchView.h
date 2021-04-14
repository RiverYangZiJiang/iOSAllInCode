//
//  SSStationSearchView.h
//  AllInCode
//
//  Created by hd on 2021/4/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSStationSearchView : UIView

@property (nonatomic,copy) void (^didSearchHandler)(NSString *text);

+ (instancetype)searchViewWithPlaceholder:(NSString *)placeholder didSearchHandler:(void (^)(NSString *message))block;

- (BOOL)becomeFirstResponder;

- (BOOL)resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
