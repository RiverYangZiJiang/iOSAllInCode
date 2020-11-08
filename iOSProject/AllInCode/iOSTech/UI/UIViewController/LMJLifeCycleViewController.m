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

/// loads or creates a view and assigns it to the view property. If the view controller has an associated nib file, this method loads the view from the nib file. This is where subclasses should create their custom view hierarchy if they aren't using a nib. Should never be called directly.
- (void)loadView
{
    NSLog(@"%s", __func__);
    [super loadView];
    
    [self life:__FUNCTION__];
}

/// Loads the view controller’s view if it has not yet been loaded.
- (void)loadViewIfNeeded{
    NSLog(@"%s", __func__);
    [super loadViewIfNeeded];
    
    [self life:__FUNCTION__];
}

/// called after the view controller has loaded its view hierarchy into memory. d. You usually override this method to perform additional initialization on views that were loaded from nib files.国内一般在该方法中添加其他UI控件，虽然官方建议在loadView方法中添加
- (void)viewDidLoad {
    NSLog(@"%s", __func__);
    [super viewDidLoad];
    [self life:__FUNCTION__];
}

/// Notifies the view controller that its view is about to be added to a view hierarchy.【因为视图消失的时候会被移除，所以出现的时候要增加】
/// @param animated <#animated description#>
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewWillAppear:animated];
    
    [self life:__FUNCTION__];
}

/// When a view's bounds change, the view adjusts the position of its subviews. Your view controller can override this method to make changes before the view lays out its subviews.
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

/// Notifies the view controller that its view is about to be removed from a view hierarchy. If you override this method, you must call super at some point in your implementation.
/// @param animated <#animated description#>
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

- (void)didReceiveMemoryWarning {
    NSLog(@"%s", __func__);
    [super didReceiveMemoryWarning];
    
    [self life:__FUNCTION__];
    
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
