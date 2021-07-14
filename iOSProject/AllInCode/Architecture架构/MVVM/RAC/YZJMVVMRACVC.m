//
//  YZJMVVMRACVC.m
//  AllInCode
//
//  Created by hd on 2021/7/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJMVVMRACVC.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSString *const reuserId = @"reuserId";

@interface YZJMVVMRACVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

/// VC持有V, VM；对于Table还是需要持有Model
@property (nonatomic, strong) MVVMViewModel *vm;

@end

@implementation YZJMVVMRACVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.vm = [[MVVMViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    // model -> UI -> 代码块
    [self.vm initWithBlock:^(id data) {
        // 获取到更新后的数据，刷新UI
        NSArray *array = data;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:array];
        
        MVVMView *view = [[MVVMView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (array.count + 1)/4*50)];
        [view headViewWithData:array];
        weakSelf.tableView.tableHeaderView = view;
//        [weakSelf.dataArray addObjectsFromArray:self.vm.dataArray];
        [weakSelf.tableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    }];
    
    [self.vm fetchData];
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserId];
    }
    return cell;
}


#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.vm.contenKey = self.dataArray[indexPath.row];
    // 这里通过修改VM的contenKey来更新数据(触发通知方法)，更新好的数据再通过block回调到VC中，完成了MVVM的双向绑定
}


#pragma mark - lazy

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserId];
    }
    return _tableView;
}

@end
