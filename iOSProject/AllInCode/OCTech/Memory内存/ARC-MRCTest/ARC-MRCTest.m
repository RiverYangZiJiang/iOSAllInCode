//
//  ARC-MRCTest.m
//  OCTest
//
//  Created by 杨子江 on 11/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ARC-MRCTest.h"

@implementation ARC_MRCTest
//- (void)strongTest{
//    NSMutableString *nameString = [NSMutableString stringWithString:@"John"];
//    self.lastName = nameString;
//    [nameString appendString:@"ny"];
//    NSLog(@"self.lastName = %@", self.lastName);  // self.lastName = Johnny
//    
//    
//    self.string1 = @"String 1";
//    self.string2 = self.string1;
//    self.string1 = nil;
//    NSLog(@"String 2 = %@", self.string2);  // String 2 = String 1
//}
//
//- (void)weakTest{
//    self.string3 = @"String 3";
//    self.string4 = self.string3;
//    self.string3 = nil;
//    NSLog(@"String 4 = %@", self.string4);  // String 4 = String 3
//}
//
//- (void)copyTest{
//    NSMutableString *nameString = [NSMutableString stringWithString:@"John"];
//    self.firstName = nameString;
//    [nameString appendString:@"ny"];
//    NSLog(@"self.firstName = %@", self.firstName);  // self.firstName = John
//    
//    
//    NSString *str = @"str";
//    self.stringCopy = str;
//    NSLog(@"str = %p, self.stringCopy = %p", str, self.stringCopy);  // str = 0x1097c8078, self.stringCopy = 0x1097c8078
//    self.stringCopy = [str copy];
//    NSLog(@"str = %p, self.stringCopy = %p", str, self.stringCopy);  // str = 0x10a348078, self.stringCopy = 0x10a348078
//}
@end
