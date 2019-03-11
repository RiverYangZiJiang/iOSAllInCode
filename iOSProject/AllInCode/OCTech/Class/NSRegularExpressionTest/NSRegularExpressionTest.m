//
//  NSRegularExpressionTest.m
//  OCTest
//
//  Created by yangzijiang on 2018/4/28.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSRegularExpressionTest.h"

@implementation NSRegularExpressionTest

+ (void)regularExpressionTest{
    NSLog(@"%d", [NSRegularExpressionTest isUrl:@"https://segbeta.huawei.com"]);  // 1
    NSLog(@"%d", [NSRegularExpressionTest isUrl:@"123https://segbeta.huawei.com"]);  // 0
    NSLog(@"%d", [NSRegularExpressionTest isUrl:@"segbeta.huawei.com"]);  // 0
    NSLog(@"%d", [NSRegularExpressionTest isUrl:@"http://"]);  // 0
}
+ (BOOL)isUrl:(NSString *)url{
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"^((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                     options:NSRegularExpressionCaseInsensitive
                                     error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:url options:0 range:NSMakeRange(0, [url length])];
    return arrayOfAllMatches.count > 0;
}
@end
