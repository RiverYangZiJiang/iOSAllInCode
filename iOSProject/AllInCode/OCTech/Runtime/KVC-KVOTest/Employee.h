//
//  Employee.h
//  IOSTest-1603
//
//  Created by 杨子江 on 4/13/16.
//  Copyright © 2016 杨子江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *surname;
@property (strong, nonatomic) NSArray *accounts;

- (Employee *)initWithDictionary:(NSDictionary *)dict;
@end
