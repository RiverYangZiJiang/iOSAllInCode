//
//  MLBaseTableVC.m
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLBaseTableVC.h"

@interface MLBaseTableVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MLBaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Getters & Setters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = color_neutral_white;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
