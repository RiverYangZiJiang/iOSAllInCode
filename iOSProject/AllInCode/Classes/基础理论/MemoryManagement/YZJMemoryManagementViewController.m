//
//  YZJMemoryManagementViewController.m
//  iOSProject
//
//  Created by yangzijiang on 2018/8/14.
//  Copyright © 2018 github.com/njhu. All rights reserved.
//

#import "YZJMemoryManagementViewController.h"
#import "LMJStaticTableViewController.h"

@interface YZJMemoryManagementViewController ()

// @property(retain)和@property(strong)同义
@property (strong, nonatomic) NSString *strongVar;

@property (strong, nonatomic) NSString *strongVar1;

// The following declaration is similar to "@property(assign) MyClass *myObject;"
// except that if the MyClass instance is deallocated, the property value is set to nil instead of remaining as a dangling pointer【悬挂指针】.
@property(assign) NSString *myObject;

@property (weak, nonatomic) NSString *weakVar;

@end

@implementation YZJMemoryManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建单元格cell
    // https://www.cnblogs.com/xiangruru/p/5068953.html
    LMJWordItem *item0 = [LMJWordItem itemWithTitle:@"strong instance variable" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        self.strongVar = @"abc";
        self.strongVar1 = self.strongVar;
        self.strongVar = nil;
        NSLog(@"%s, self.strongVar1 = %@", __func__, self.strongVar1);  // self.strongVar1 = abc
        [MBProgressHUD showAutoMessage:self.strongVar1];
    }];
    
    self.addItem(item0);
    
    LMJWordItem *item1 = [LMJWordItem itemWithTitle:@"weak instance variable" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        self.strongVar = @"abc";
        self.weakVar = self.strongVar;
        self.strongVar = nil;
        NSLog(@"%s, self.weakVar = %@", __func__, self.weakVar);  // self.weakVar = abc
        [MBProgressHUD showAutoMessage:self.weakVar];
    }];
    
    self.addItem(item1);
    
    LMJWordItem *item2 = [LMJWordItem itemWithTitle:@"Assigning retained object to weak variable" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        // 会报“Assigning retained object to weak variable; object will be released after assignment”的警告
        // Although string is used after the initial assignment, there is no other strong reference to the string object at the time of assignment; it is therefore immediately deallocated. The log statement shows that string has a null value. (The compiler provides a warning in this situation.)
        NSString * __weak string = [[NSString alloc] initWithFormat:@"First Name"];
        NSLog(@"%s, string = %@", __func__, string);  // string = (null)
        [MBProgressHUD showAutoMessage:string];
    }];
    
    self.addItem(item2);
    
    
}

#pragma mark - weak
// https://www.cnblogs.com/xiangruru/p/5068953.html iOS 底层解析weak的实现原理（包含weak对象的初始化，引用，释放的分析)
// https://blog.csdn.net/u014205968/article/details/67639341 iOS runtime探究(五): 从runtime开始深入weak实现机理

@end
