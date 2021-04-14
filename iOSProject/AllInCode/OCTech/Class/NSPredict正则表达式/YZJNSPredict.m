//
//  YZJNSPredict.m
//  AllInCode
//
//  Created by hd on 2021/3/27.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJNSPredict.h"

@implementation YZJNSPredict
/// 是否为密码，长度8~20，包含数字/字母/字符中两种以上组合
+ (BOOL)isPassword:(NSString *)str {
    if (str.length < 8 || str.length > 20) {
        return false;
    }
    
    if ([self containsLetter:str] && ![self isPureLetter:str]) {
        return true;
    }
    
    if ([self containsNumber:str] && ![self isPureNumber:str]) {
        return true;
    }
    
    return false;
}

/// 是否包含数字
+ (BOOL)containsNumber:(NSString *)str {
    NSString *regex = @".*[0-9].*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    DLog(@"%d", [predicate evaluateWithObject:str]);
    return [predicate evaluateWithObject:str];
}

/// 是否包含字母
+ (BOOL)containsLetter:(NSString *)str {
    NSString *regex = @".*[a-zA-Z].*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    DLog(@"%d", [predicate evaluateWithObject:str]);
    return [predicate evaluateWithObject:str];
}

/// 是否为纯数字
+ (BOOL)isPureNumber:(NSString *)str {
    NSString *regex = @"^[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}

/// 是否为纯字母
+ (BOOL)isPureLetter:(NSString *)str {
    NSString *regex = @"^[a-zA-Z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}

@end
