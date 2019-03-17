//
//  Employee.m
//  IOSTest-1603
//
//  Created by 杨子江 on 4/13/16.
//  Copyright © 2016 杨子江. All rights reserved.
//

#import "Employee.h"

@implementation Employee

- (Employee *)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        // 通过KVC给对象各成员变量赋值，哪怕是数组都可以，这种赋值可以放在对象初始化上
        for (NSString *key in [dict allKeys]) {
            [self setValue:[dict objectForKey:key] forKey:key];
        }
    }
    
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%s: name = %@, surname = %@, accounts = %@", __func__, self.name, self.surname, self.accounts];
}
@end
