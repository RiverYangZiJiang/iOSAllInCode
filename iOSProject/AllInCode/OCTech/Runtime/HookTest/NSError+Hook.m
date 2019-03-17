//
//  NSError+Hook.m
//  OCTest
//
//  Created by yangzijiang on 2018/12/11.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSError+Hook.h"
#import <objc/runtime.h>

@implementation NSError (Hook)
+ (void)load{
    
    //调换IMP
    Method originalMethod = class_getInstanceMethod([NSError class], @selector(description));
    Method myMethod = class_getInstanceMethod([NSError class], @selector(qs_description));
    method_exchangeImplementations(originalMethod, myMethod);
}

- (NSString *)qs_description{
    // 最多打印150个字符
    NSUInteger maxCharacters = 150;
    
    if([self qs_description].length > maxCharacters){
        return [[self qs_description] substringToIndex:maxCharacters];
    }
    
    return [self qs_description];
}

@end
