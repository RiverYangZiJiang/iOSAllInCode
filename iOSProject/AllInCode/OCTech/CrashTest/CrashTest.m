//
//  CrashTest.m
//  OCTest
//
//  Created by yangzijiang on 09/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "CrashTest.h"

@implementation CrashTest
+ (void)crashTest{
    [CrashTest unrecognizedSelector:[[NSNull alloc] init]];
}
// 调用空的block会崩溃

/**
  调用非空对象不存在的方法会崩溃；nil对象调用任何方法都只是返回nil，不会崩溃

 @param obj <#obj description#>
 */
+ (void)unrecognizedSelector:(id)obj{
    [(NSString *)obj isEqualToString:@"abc"];  // -[NSNull isEqualToString:]: unrecognized selector sent to instance
}

+ (void)arrayCrashTest{
    // 对空数组遍历并不会崩溃，所以不需要事先判断数组是否为空
    NSArray *array;
    for (id item in array) {
        NSLog(@"item = %@", item);
    }
    
    // nil调用方法会返回nil
    if (!array.count) {
        NSLog(@"array.count == 0");
    }
    
    NSLog(@"arrayCrashTest end");
}

+ (void)avoidCrashTest{
    NSString *nilString = nil;
//    NSArray *array = @[@"array", nilString];
    
    NSMutableArray *ma = nil;
    [ma objectAtIndex:10];  // 因为ma为nil，所以不会崩溃
    ma[11];  // 因为ma为nil，所以不会崩溃
//    ma[18446744073709551615];  // 因为ma为nil，所以不会崩溃
    
//    ma = [NSMutableArray arrayWithObjects:@"ma", nil];
//    ma[12];  // -[__NSArrayM objectAtIndexedSubscript:]: index 12 beyond bounds [0 .. 0]
//    [ma objectAtIndex:13];  // -[__NSArrayM objectAtIndex:]: index 13 beyond bounds [0 .. 0]
    
    ma = [NSMutableArray array];
    ma[18446744073709551615];  // -[__NSArrayM objectAtIndexedSubscript:]: index 18446744073709551615 beyond bounds for empty array
    
    
    NSLog(@"avoidCrashTest end");
}
@end
