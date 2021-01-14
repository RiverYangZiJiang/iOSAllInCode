//
//  YZJCountDownTool.h
//  AllInCode
//
//  Created by hd on 2021/1/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 
@interface YZJCountDownTool : NSObject

/**
 *  获取当天的字符串
 *  @return 格式为年-月-日 时分秒
 */
+ (NSString *)getCurrentTimeyyyymmdd;

/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;
@end

NS_ASSUME_NONNULL_END
