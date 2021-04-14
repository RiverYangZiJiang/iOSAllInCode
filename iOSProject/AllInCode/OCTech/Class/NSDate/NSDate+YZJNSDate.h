//
//  NSDate+YZJNSDate.h
//  AllInCode
//
//  Created by hd on 2021/3/26.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+YZJNSDate.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSDate (YZJNSDate)
/// 获取13位时间戳
+ (NSString *)getCurr13BitTime;

/// 获取13位时间戳
+ (NSString *)getCurr13BitTimeOfDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
