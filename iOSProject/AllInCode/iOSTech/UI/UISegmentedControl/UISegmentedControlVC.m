//
//  UISegmentedControlVC.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/10.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UISegmentedControlVC.h"
#import "MLCustomSegmentedControl.h"

#define ColorI(c) [UIColor colorWithRed:((c>>16)&0xff)/255.0 green:((c>>8)&0xff)/255.0 blue:(c&0xff)/255.0 alpha:1.0] // ColorI(0xbfbfbf)

#define ColorI_A(c,a) [UIColor colorWithRed:((c>>16)&0xff)/255.0 green:((c>>8)&0xff)/255.0 blue:(c&0xff)/255.0 alpha:a] // ColorI(0xbfbfbf)

@interface UISegmentedControlVC ()<MLCustomSegmentedControlDelegate>
// 系统
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
/// 自定义
@property (strong, nonatomic) MLCustomSegmentedControl *MLCustomSegmentedControl;
@end

@implementation UISegmentedControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
//    self.navigationItem.titleView = self.segmentedControl;
    self.navigationItem.titleView = self.MLCustomSegmentedControl;
}

#pragma mark - MLCustomSegmentedControlDelegate
- (void)MLCustomSegmentedControlItemViewClicked:(NSInteger)index{
    NSLog(@"%s index = %ld", __func__, (long)index);
}

#pragma mark - Custom Accessors
- (MLCustomSegmentedControl *)MLCustomSegmentedControl{
    if (!_MLCustomSegmentedControl) {
        _MLCustomSegmentedControl = [[MLCustomSegmentedControl alloc] init];
        _MLCustomSegmentedControl.frame = CGRectMake(0, 0, 200, 48);
        _MLCustomSegmentedControl.selectedIndex = 0;
        _MLCustomSegmentedControl.titles = @[@"Market", @"My Tools"];
        _MLCustomSegmentedControl.delegate = self;
    }
    return _MLCustomSegmentedControl;
}

- (UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"全部",@"被查看",@"待沟通",@"面试",@"不合适"]];
        _segmentedControl.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
        
        _segmentedControl.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                   NSForegroundColorAttributeName: ColorI(0x989898)};
        [_segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        
        NSDictionary* unselectedTextAttributes2 = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                                    NSForegroundColorAttributeName: ColorI(0x1BB28B)};
        [_segmentedControl setTitleTextAttributes:unselectedTextAttributes2 forState:UIControlStateSelected];
        _segmentedControl.backgroundColor = ColorI(0xF7F7FA);
        [_segmentedControl addTarget:self action:@selector(segmentSelectedAction:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}

@end
