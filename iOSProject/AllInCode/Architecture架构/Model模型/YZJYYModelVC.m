//
//  YZJYYModelVC.m
//  AllInCode
//
//  Created by hd on 2021/6/30.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJYYModelVC.h"
#import "YZJModel.h"

@interface YZJYYModelVC ()
///
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation YZJYYModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"保存模型" subTitle:@"包括UIImage对象" itemOperation:^(NSIndexPath *indexPath) {
        YZJModel *model = [YZJModel new];
        model.name = @"yzj";
        model.image = [UIImage imageNamed:@"AppIcon"];
        [model cacheModel];
    }]);
    
    WeakSelf
    self.addItem([LMJWordItem itemWithTitle:@"取模型" subTitle:@"包括UIImage对象" itemOperation:^(NSIndexPath *indexPath) {
        YZJModel *model = [YZJModel getCacheModel];
        weakSelf.imageView.image = model.image;
    }]);
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_activity"]];
    }
    return _imageView;
}

@end
