//
//  NSDictionaryTest.m
//  OCTest
//
//  Created by yangzijiang on 2018/10/23.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSDictionaryTest.h"

@implementation NSDictionaryTest

#pragma mark - 字典的保存
/*
 字典可以直接保存到plist文件中；
 字典若以字符串保存到数据库Text字段中，读取出来不能将Text字段转换为字典。需要先转换为NSData，保存到bolb类型；
 sqlite数据库利用bold类型存储与读取字典https://blog.csdn.net/qq_31382921/article/details/51354265
 
 https://blog.csdn.net/yuhao111122/article/details/50451841
 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
 
 NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 */


@end
