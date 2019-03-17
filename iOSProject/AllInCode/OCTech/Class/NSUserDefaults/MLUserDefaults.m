//
//  MLUserDefaults.m
//  OCTest
//
//  Created by yangzijiang on 2019/2/23.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLUserDefaults.h"

@implementation MLUserDefaults
+ (void)userDefaultsTest{
    [self suiteNameTest];
}

+ (void)suiteNameTest{
    NSUserDefaults *shareDefaultA = [[NSUserDefaults alloc]initWithSuiteName:@"com.storage.demo"];  // 会创建一个Library/Preferences/com.storage.demo.plist文件
    [shareDefaultA setObject:@"appA" forKey:@"shareKey"];
}

@end
