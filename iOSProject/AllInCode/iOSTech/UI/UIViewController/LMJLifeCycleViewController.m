//
//  LMJLifeCycleViewController.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/13.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJLifeCycleViewController.h"

@interface LMJLifeCycleViewController ()


@end

@implementation LMJLifeCycleViewController
#pragma mark - 生命周期
- (instancetype)init
{
    NSLog(@"%s", __func__);
    self = [super init];
    if (self) {
        [self life:__FUNCTION__];
    }
    return self;
}

- (void)loadView
{
    NSLog(@"%s", __func__);
    [super loadView];
    
    [self life:__FUNCTION__];
}

- (void)viewDidLoad {
    NSLog(@"%s", __func__);
    [super viewDidLoad];
    [self life:__FUNCTION__];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewWillAppear:animated];
    
    [self life:__FUNCTION__];
}

- (void)didReceiveMemoryWarning {
    NSLog(@"%s", __func__);
    [super didReceiveMemoryWarning];
    
    [self life:__FUNCTION__];
    
}

- (void)viewWillLayoutSubviews
{
    NSLog(@"%s", __func__);
    [super viewWillLayoutSubviews];
    
    [self life:__FUNCTION__];
}

- (void)viewDidLayoutSubviews
{
    NSLog(@"%s", __func__);
    [super viewDidLayoutSubviews];
    
    [self life:__FUNCTION__];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewDidAppear:animated];
    
    [self life:__FUNCTION__];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewWillDisappear:animated];
    
    [self life:__FUNCTION__];
}


- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewDidDisappear:animated];
    
    [self life:__FUNCTION__];
}

- (void)awakeFromNib
{
    NSLog(@"%s", __func__);
    [super awakeFromNib];
    
    [self life:__FUNCTION__];
}

// Quick Help里写清楚了这个方法的用法，多看Quick Help
- (void)dealloc{
    NSLog(@"%s", __func__);
    // In an implementation of dealloc, do not invoke the superclass’s implementation. 实现dealloc里，不要调用[super dealloc];
    // You override this method to dispose of resources other than the object’s instance variables覆盖这个方法，以处理除对象实例变量之外的资源
    // 在 dealloc 方法中，尽量不要使用 . 语法对成员变量的访问。会容易触发 KVO 以及其它额外的操作。当然了，这是一个习惯的问题，如果这个属性根本就没有做任何的 KVO 以及实现什么 getter 与 setter 方法的话，也没有什么影响。但是有一个问题是，当前的 class 没有做，不代表以后的子类不做。所以尽量不要使用 . 语法。如销毁定时器，建议使用以下格式
//    // 停止定时器
//    {        // 尽量不要使用 self.blockTimer
//        [_blockTimer invalidate];
//        _blockTimer = nil;
//    }

}

#pragma mark - Private
- (void)life:(const char *)func
{
    LMJWordItem *item = [LMJWordItem itemWithTitle:[NSString stringWithUTF8String:func] subTitle:nil itemOperation:nil];
    item.titleFont = [UIFont systemFontOfSize:12];
    
    self.addItem(item);
    
    [self.tableView reloadData];
}

@end
