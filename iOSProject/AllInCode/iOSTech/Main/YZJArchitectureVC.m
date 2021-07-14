//
//  YZJArchitectureVC.m
//  iOSAllInCode
//
//  Created by 杨子江 on 3/10/19.
//  Copyright © 2019 杨子江. All rights reserved.
//

#import "YZJArchitectureVC.h"

@interface YZJArchitectureVC ()

@end

@implementation YZJArchitectureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示内容并且可以点击，section和item
    self.addItem([LMJWordArrowItem itemWithTitle:@"NetworkLayer" subTitle:@"NetworkLayer" destVc:@"YZJNetworkLayerVC"]);
    
    self.addItem([LMJWordArrowItem itemWithTitle:@"组件化" subTitle:@"私有Pod-CTMediator" destVc:@"YZJComponentsVC"]);
    
    self.addItem([LMJWordArrowItem itemWithTitle:@"模型层" subTitle:@"YYModel" destVc:@"YZJYYModelVC"]);
    
    self.addItem([LMJWordArrowItem itemWithTitle:@"YZJMVVMVC" subTitle:@"" destVc:@"YZJMVVMVC"]);
    
    
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
