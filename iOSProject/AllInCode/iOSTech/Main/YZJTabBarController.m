//
//  YZJTabBarController.m
//  iOSAllInCode
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 杨子江. All rights reserved.
//

#import "YZJTabBarController.h"
//#import "UINavigationController.h"
#import "YZJiOSTechVC.h"
#import "YZJOCTechVC.h"
#import "YZJProjectVC.h"
#import "YZJArchitectureVC.h"
#import "YZJToolVC.h"

@interface YZJTabBarController ()<UITabBarControllerDelegate>

@end

@implementation YZJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor redColor];  // tabBar标题默认为蓝色，在此修改为红色
    [self setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, -3)] forKeyPath:LMJKeyPath(self, titlePositionAdjustment)];  // 标题向上提3
    [self setupTabBarItems];
    [self setupViewControllers];
    self.delegate = self;
}

- (void)setupTabBarItems{
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"iosTech",
                            CYLTabBarItemImage : @"tabBar_essence_icon",
                            CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                            };
    
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"OCTech",
                            CYLTabBarItemImage : @"tabBar_friendTrends_icon",
                            CYLTabBarItemSelectedImage : @"tabBar_friendTrends_click_icon",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"Project",
                            CYLTabBarItemImage : @"tabBar_new_icon",
                            CYLTabBarItemSelectedImage : @"tabBar_new_click_icon",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"Architecture",
                            CYLTabBarItemImage : @"tabBar_me_icon",
                            CYLTabBarItemSelectedImage : @"tabBar_me_click_icon"
                            };
    NSDictionary *dict5 = @{
                            CYLTabBarItemTitle : @"Tool",
                            CYLTabBarItemImage : @"tabbar_discover",
                            CYLTabBarItemSelectedImage : @"tabbar_discover_highlighted"
                            };
    self.tabBarItemsAttributes = @[dict1, dict2, dict3, dict4, dict5];
}

- (void)setupViewControllers{
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:[[YZJiOSTechVC alloc] init]];
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:[[YZJOCTechVC alloc] init]];
    UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:[[YZJProjectVC alloc] init]];
    UINavigationController *nc4 = [[UINavigationController alloc] initWithRootViewController:[[YZJArchitectureVC alloc] init]];
    UINavigationController *nc5 = [[UINavigationController alloc] initWithRootViewController:[[YZJToolVC alloc] init]];
    self.viewControllers = @[nc1, nc2, nc3, nc4, nc5];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}
@end
