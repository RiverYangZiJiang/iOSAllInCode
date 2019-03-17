//
//  ViewController.m
//  CopyAndMutableCopy
//
//  Created by yangzijiang on 28/12/2017.
//  Copyright © 2017 yangzijiang. All rights reserved.
//

#import "ViewController.h"

//1.copy与mutableCopy总结
//相同点：
//两者返回的都是原对象的副本，当修改复制的副本时，原对象不会受到影响
//不同点：
//copy不管是对可变对象还是不可变对象，返回的都是不可变对象，如
//NSString book = [NSMutableString sting];
//mutableCopy不管是对可变对象还是不可变对象，返回的都是可变对象

//2.@property里的copy相当于赋值时调用copy方法，如@property (copy) NSString *name;的setter的实现是this.name = [name copy];

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testCopyM];
    [self testCopy];
}


- (void)testCopy {
    NSString *book = @"ios guid";
    NSString *bookC = [book copy];
    NSLog(@"bookC = %@", bookC);
    
    NSMutableString *bookM = [NSMutableString stringWithFormat:@"ios guid M"];
    NSMutableString *bookCM = [bookM copy];
    // 会报-[NSTaggedPointerString appendString:]: unrecognized selector sent to instance 0x2363f500a9f3a5
    [bookCM appendString:@" 123"];
    NSLog(@"bookCM = %@", bookCM);
}

- (void)testCopyM {
    NSString *book = @"ios guid";
    NSMutableString *bookMC = [book mutableCopy];
    [bookMC  appendString:@"123"];
    NSLog(@"book = %@, bookMC = %@", book, bookMC);
}


@end
