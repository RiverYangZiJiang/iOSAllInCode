//
//  YZJUIBezierPathVC.m
//  AllInCode
//
//  Created by hd on 2021/4/7.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJUIBezierPathVC.h"
#import "UIBezierPathView.h"

@interface YZJUIBezierPathVC ()
///
@property (nonatomic, strong) UIBezierPathView *bezierPathView;
@end

@implementation YZJUIBezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容不可点击
    
    [self.view addSubview:self.bezierPathView];
    self.bezierPathView.frame = CGRectMake(100, 100, 100, 100);
}

- (UIBezierPathView *)bezierPathView {
    if (!_bezierPathView) {
        _bezierPathView = [[UIBezierPathView alloc] init];
    }
    return _bezierPathView;
}


@end
