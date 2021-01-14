//
//  YZJUIViewVC.m
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJUIViewVC.h"
#import "YZJCornerVC.h"

@interface YZJUIViewVC ()

@end

@implementation YZJUIViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"圆角" subTitle:nil];
    item00.destVc = [YZJCornerVC class];
    
    self.addItem(item00);
}



@end
