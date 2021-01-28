//
//  YZJImageLoopViewController.m
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJImageLoopViewController.h"

@interface YZJImageLoopViewController ()
///
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation YZJImageLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(100, 100, 100, 100);
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine-setting-icon"]];
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //顺时针效果，将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        animation.duration  = 3;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;  // 解决切换到后台动画失效的问题[3]
        [_imageView.layer addAnimation:animation forKey:nil];

        [_imageView.layer addAnimation:animation forKey:@"animation"];
    }
    return _imageView;
}

@end
