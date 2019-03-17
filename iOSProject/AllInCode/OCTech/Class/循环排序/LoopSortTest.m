//
//  LoopSortTest.m
//  OCTest
//
//  Created by yangzijiang on 2018/11/7.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "LoopSortTest.h"

@implementation LoopSortTest
+ (void)loopSortTest{
    /*
     https://segmentfault.com/q/1010000004586112
     用 for-in 去遍历容器时：
     NSArray，是按照数组 index 的顺序来遍历。
     NSDictionary，是通过遍历字典的 keys 数组，再通过 valueForKey: 来获取 value。
     NSSet，是无序的。
     */
    NSArray *array = @[@"1", @"3", @"5", @"2", @"4"];
    NSDictionary *dict = @{@"1":@"1", @"3":@"3", @"5":@"5", @"2":@"2", @"4":@"4"};
    
    for (NSString *str in array) {
        NSLog(@"array for in str = %@", str);
    }
    
    // enumerateObjectsUsingBlock按数组顺序遍历，starting with the first object and continuing through the array to the last object.
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"array enumerateObjectsUsingBlock obj = %@", obj);
    }];
    
    for (NSString *str in dict.allKeys) {
        NSLog(@"dict value = %@", dict[str]);
    }
}
@end
