//
//  YZJMultiThreadVC.m
//  AllInCode
//
//  Created by hd on 2021/4/28.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJMultiThreadVC.h"

@interface YZJMultiThreadVC ()

@end

@implementation YZJMultiThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addItem([LMJWordArrowItem itemWithTitle:@"NSOperation" subTitle:@"" destVc:@"YZJNSOperationVC"]);
    self.addItem([LMJWordArrowItem itemWithTitle:@"GCD" subTitle:@"" destVc:@"YZJGCDVC"]);
}



@end
