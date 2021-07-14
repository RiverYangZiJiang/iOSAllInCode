//
//  YZJComponentsVC.m
//  AllInCode
//
//  Created by hd on 2021/6/21.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJComponentsVC.h"
// import私有pod
#import <PrivatePod/PrivateClass.h>
//#import <YZJA/CTMediator+YZJA.h>
#import <CTMediator/CTMediator.h>
#import <YZJSwift/YZJSwift-Swift.h>

@interface YZJComponentsVC ()

@end

@implementation YZJComponentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容不可点击
//    [self addTitle:@"title" subTitle:@"subTitle"];
    
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"私有pod" subTitle:@"调用方法" itemOperation:^(NSIndexPath *indexPath) {
        [[[PrivateClass alloc] init] printFuncName];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"私有pod" subTitle:@"OC -> Swift Extension" itemOperation:^(NSIndexPath *indexPath) {
        // Objective-C -> Extension -> Swift
        UIViewController *viewController = [[CTMediator sharedInstance] YZJSwift_demoWithName:@"yzj" callback:^(NSString * _Nonnull result) {
            NSLog(@"%s, result: %@", __func__, result);
        }];
        [self.navigationController pushViewController:viewController animated:YES];
    }]);
    

    
    // 调用A工程里的方法
//    NSString *str = [[CTMediator sharedInstance] YZJA_test];
//    [self addTitle:@"调用YZJA工程方法返回值" subTitle:str];
    
    // 展示内容可点击可跳转，默认加入section0
//    self.addItem([LMJWordArrowItem itemWithTitle:<#(NSString *)#> subTitle:<#(NSString *)#> destVc:<#(NSString *)#>]);
    
    // 展示内容可点击不可跳转，默认加入section0
//    self.addItem([LMJWordArrowItem itemWithTitle:<#(NSString *)#> subTitle:<#(NSString *)#> itemOperation:^(NSIndexPath *indexPath) {
//        <#code#>
//    }]);
    
    // 展示内容并且可以点击，section和item
//    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"MLUI" subTitle:@"自定义UI" destVc:@"destVc"];
//    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:@"UI" footerTitle:nil];
//    [self.sections addObjectsFromArray:@[section0]];
    
}



@end
