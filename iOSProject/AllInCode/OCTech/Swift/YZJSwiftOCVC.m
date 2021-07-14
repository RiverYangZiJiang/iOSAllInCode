//
//  YZJSwiftOCVC.m
//  AllInCode
//
//  Created by hd on 2021/7/8.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJSwiftOCVC.h"
#import "AllInCode-Swift.h"

@interface YZJSwiftOCVC ()

@end

@implementation YZJSwiftOCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"OC调用Swift" subTitle:@"" itemOperation:^(NSIndexPath *indexPath) {
        Test *test = [[Test alloc] init];
        [test show];
    }]);
    
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
