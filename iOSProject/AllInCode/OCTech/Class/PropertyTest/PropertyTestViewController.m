//
//  PropertyTestViewController.m
//  OCTest
//
//  Created by 杨子江 on 11/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "PropertyTestViewController.h"

@interface PropertyTestViewController ()
@property (nonatomic) NSString *name;

// 给本对象赋值时，本对象将拥有自己的拷贝
@property (copy, nonatomic) NSString *nameCopy;
@end

@implementation PropertyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self copyTest];
}

- (void)copyTest {
    NSMutableString *nameString = [NSMutableString stringWithString:@"Jhon"];
    self.name = nameString;
    self.nameCopy = nameString;
    NSLog(@"nameString = %@, nameStringP = %p, self.name = %@, self.nameP = %p, self.nameCopy = %@, self.nameCopyP = %p", nameString, nameString, self.name, self.name, self.nameCopy, self.nameCopy);  // nameString = Jhon, nameStringP = 0x7fb8fa62b680, self.name = Jhon, self.nameP = 0x7fb8fa62b680, self.nameCopy = Jhon, self.nameCopyP = 0xa0000006e6f684a4
    [nameString appendString:@"ly"];
    NSLog(@"nameString = %@, nameStringP = %p, self.name = %@, self.nameP = %p, self.nameCopy = %@, self.nameCopyP = %p", nameString, nameString, self.name, self.name, self.nameCopy, self.nameCopy);  // nameString = Jhonly, nameStringP = 0x7fb8fa62b680, self.name = Jhonly, self.nameP = 0x7fb8fa62b680, self.nameCopy = Jhon, self.nameCopyP = 0xa0000006e6f684a4
    
    //    如果读者需要直接设置带有copy特性的属性的实例变量【带下划线的属性即为instance variable】，例如在一个初始化方法中，不要忘记对初始的对象进行复制操作：
    //
    //    - (id)initWithSomeOriginalString:(NSString *)aString {
    //        self = [super init];
    //        if (self) {
    //            _instanceVariableForCopyProperty = [aString copy];  // 非实例变量可不copy
    //        }
    //        returnself;
    //    }
}

@end
