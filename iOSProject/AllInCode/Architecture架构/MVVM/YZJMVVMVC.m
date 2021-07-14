//
//  YZJMVVMVC.m
//  AllInCode
//
//  Created by hd on 2021/7/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJMVVMVC.h"

@interface YZJMVVMVC ()

@end

@implementation YZJMVVMVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容不可点击
//    [self addTitle:@"title" subTitle:@"subTitle"];
    
    // 展示内容可点击不跳转
//    self.addItem([LMJWordItem itemWithTitle:@"MVVM+RAC" subTitle:@"" itemOperation:^(NSIndexPath *indexPath) {
//
//    }]);
    
    // 展示内容可点击可跳转，默认加入section0
    self.addItem([LMJWordArrowItem itemWithTitle:@"MVVM+RAC" subTitle:@"" destVc:@"YZJMVVMRACVC"]);
    
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
