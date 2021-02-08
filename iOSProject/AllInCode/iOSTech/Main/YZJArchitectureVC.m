//
//  YZJArchitectureVC.m
//  iOSAllInCode
//
//  Created by 杨子江 on 3/10/19.
//  Copyright © 2019 杨子江. All rights reserved.
//

#import "YZJArchitectureVC.h"
#import "YZJNetworkLayerVC.h"

@interface YZJArchitectureVC ()

@end

@implementation YZJArchitectureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示内容并且可以点击，section和item
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"NetworkLayer" subTitle:@"NetworkLayer"];
    item00.destVc = [YZJNetworkLayerVC class];
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:@"1" footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
