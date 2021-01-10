//
//  CPActivityController.m
//  ChargePlatform
//
//  Created by HMDS on 2021/1/5.
//  Copyright © 2021 EverGrande. All rights reserved.
//

#import "CPActivityController.h"
#import "CPActivityNavigationBar.h"
#import "GHUIDefine.h"
#import "MJRefresh.h"

@interface CPActivityController ()
@property (nonatomic, strong) UITableView *tableView;
/// 自定义导航条
@property (nonatomic, strong) CPActivityNavigationBar *customNavigationBar;
@property (nonatomic, strong) UIImageView *topBackgroundImageView;

@end

@implementation CPActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.topBackgroundImageView];
    [self.view addSubview:self.customNavigationBar];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条 《iOS 导航栏的正确隐藏方式http://www.jishudog.com/28853/html》
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.topBackgroundImageView.top = 0;
    self.topBackgroundImageView.left = 0;
    self.topBackgroundImageView.width = self.view.width;
    self.topBackgroundImageView.height = SH(161);
    
    self.customNavigationBar.top =  0;
    self.customNavigationBar.left = 0;
    self.customNavigationBar.width = self.view.width;
    self.customNavigationBar.height = SC_STATUS_BAR_HEIGHT + self.navigationController.navigationBar.height;
    
    self.tableView.left = 0;
    self.tableView.top =  self.customNavigationBar.bottom;
    self.tableView.width = self.view.width;
    self.tableView.height = self.view.bottom - self.tableView.top;
}

#pragma mark - Getters & Setters
- (CPActivityNavigationBar *)customNavigationBar {
    if (!_customNavigationBar) {
        _customNavigationBar = [[CPActivityNavigationBar alloc] initWithTitle:@"福利中心" doneBlock:^(UIButton * _Nonnull button) {
            NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
        }];
    }
    return _customNavigationBar;
}

- (UIImageView *)topBackgroundImageView {
    if (!_topBackgroundImageView) {
        _topBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_activity"]];
    }
    return _topBackgroundImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"%@ %s", NSStringFromClass([self class]), __func__);
        }];
        // 设置颜色
        header.stateLabel.textColor = [UIColor whiteColor];
        header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
        _tableView.mj_header = header;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
