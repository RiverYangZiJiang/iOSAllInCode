//
//  BlockTest.m
//  CLanguageTest-2018
//
//  Created by yangzijiang on 27/01/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "BlockTest.h"

/**
 block块可理解为可以做参数的特殊函数，只不过定义语法格式和函数不完全一样。block可以像函数一样单独调用；也可以作为函数形参，让用户去实现这个block，这样在函数执行完某些操作之后再回调该block
 Blocks are Objective-C objects，使用block可以简化OC编程。以下是定义block的基本语法格式，在snippet输入block即可得到其格式
 <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
 <#statements#>
 };
 */

//typedef <#returnType#>(^<#name#>)(<#arguments#>);
// 作为形参的block类型
typedef void(^GetCapitalNameBlock)(NSString *name);

@implementation BlockTest

NSString * (^printInfo)(NSString *name, unsigned int age) = ^(NSString *name, unsigned int age) {
    NSLog(@"name = %@, age = %ul", name, age);
    return name;
};

+ (void)blockTest{
    NSString *name = printInfo(@"zs", 30);
    NSLog(@"name = %@", name);
    [BlockTest argumentsBlock:1 block:^(NSString *name) {
        NSLog(@"name = %@", name);
    }];
    
    [BlockTest argumengsBlock1:^(NSString *str) {
        NSLog(@"str = %@", str);
    }];
}

+ (void)argumentsBlock:(NSInteger)num block:(GetCapitalNameBlock)block{
    if (num%2 == 0) {
        NSLog(@"偶数");
    }else{  // 满足一定条件才调用用户自己实现的block，并且给block传递参数
        block(@"ls");
    }
}

+ (void)argumengsBlock1:(void(^)(NSString *str))block{
    NSString *info = @"argumengsBlock1";
    // 注：本方法中不能直接调用str，会报"Use of undeclared identifier 'str'"，而是在回调中，传递给block的参数会赋值给str
//    str = info;
//    block(str);
    // 正解
    block(info);
}

@end
