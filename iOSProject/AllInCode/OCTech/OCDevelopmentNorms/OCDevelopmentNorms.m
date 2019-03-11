//
//  OCDevelopmentNorms.m
//  OCTest
//
//  Created by yangzijiang on 07/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "OCDevelopmentNorms.h"

@interface OCDevelopmentNorms ()

@end

@implementation OCDevelopmentNorms
- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)setName:(NSString *)name{
    _name = name;
}

- (void)printName{
    NSLog(@"name = %@", _name);
}


@end
