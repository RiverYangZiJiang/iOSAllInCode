//
//  NSStringTest.m
//  OCTest
//
//  Created by yangzijiang on 09/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSStringTest.h"
#import "NSString+Category.h"

@implementation NSStringTest

+ (void)stringTest{
//    NSString *str = @{@"key":@"value"};
//    NSLog(@"abc.length = %lu", (unsigned long)@"abc".length);
//    NSLog(@"str.length = %lu", (unsigned long)str.length);
//    [NSStringTest stringByReplacingOccurrencesOfStringTest];
    [NSStringTest changeLine];
}

/**
 
 */
+ (void)changeLine{
    NSLog(@"%@", [NSString stringWithFormat:@" name\
yzj"]);  // 不换行 nameyzj
    NSLog(@"%@", [NSString stringWithFormat:@" name\nyzj"]);  // 换行
}
#pragma mark - filePath
+ (void)fileName:(NSString *)filePath
{
    //从路径中获得完整的文件名 （带后缀）
    NSString *fileName = [filePath lastPathComponent];
    
    //获得文件名 （不带后缀）
    NSString *fileName1 = [filePath stringByDeletingPathExtension];
    
    //获得文件的后缀名 （不带'.'）
    NSString *suffix = [filePath pathExtension];
}


+ (void)compareTest{
    NSString *arg1 = @"0";
    NSString *arg2 = nil;
    NSComparisonResult result = [arg1 compare:arg2 options:NSNumericSearch];
    NSLog(@"result = %ld", (long)result);  // result = 1
    BOOL resultA = [arg1 compare:arg2 options:NSNumericSearch] == NSOrderedAscending;
    NSLog(@"resultA = %ld", (long)resultA); // resultA = 0
    BOOL resultD = [arg1 compare:arg2 options:NSNumericSearch] == NSOrderedAscending;
    NSLog(@"resultD = %ld", (long)resultD);  // result = 1
    
    NSLog(@"result arg2 compare:arg2 = %ld", (long)[arg2 compare:arg2 options:NSNumericSearch]);  // result arg2 compare:arg2 = 0
    NSLog(@"result arg2 compare:arg1 = %ld", (long)[arg2 compare:arg1 options:NSNumericSearch]);  // result arg2 compare:arg1 = 0
    
    // 官方已经修改完bug，3.1.10大于3.1.5
    NSLog(@"result = %d", [@"3.1.10" compare:@"3.1.5" options:NSNumericSearch] >= NSOrderedSame);  // result = 1
}

+ (void)stringByReplacingOccurrencesOfStringTest{
    NSString *url = @"https://sgbeta.owsgo.com";
    NSLog(@"%@", [url stringByReplacingOccurrencesOfString:@"https://" withString:@""]);  // sgbeta.owsgo.com
}
@end
