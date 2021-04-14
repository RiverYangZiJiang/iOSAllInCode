//
//  SSStationSearchViewVC.m
//  AllInCode
//
//  Created by hd on 2021/4/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "SSStationSearchViewVC.h"
#import "SSStationSearchView.h"

@interface SSStationSearchViewVC ()
///
@property (nonatomic, strong) SSStationSearchView *searchView;
@end

@implementation SSStationSearchViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s start", __func__);
    self.searchView = [SSStationSearchView searchViewWithPlaceholder:@"请输入场站名称" didSearchHandler:^(NSString * _Nonnull message) {
        NSLog(@"%s, message: %@", __func__, message);
    }];
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.equalTo(self.view).offset(100);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(32);
    }];
    NSLog(@"%s end", __func__);
}

@end
