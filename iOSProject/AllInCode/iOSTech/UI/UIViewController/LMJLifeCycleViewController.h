//
//  LMJLifeCycleViewController.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/13.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJStaticTableViewController.h"
/*
 生命周期顺序 注：从后台到前台不会调用viewWillAppear；pop回本界面会调用viewWillAppear
 [UIViewControllerTestVC viewDidLoad]
 [UIViewControllerTestVC viewWillAppear:]  // view被加载时才会调用
 [UIViewControllerTestVC viewWillLayoutSubviews]
 [UIViewControllerTestVC viewDidLayoutSubviews]
 [UIViewControllerTestVC viewDidAppear:]
 
 注：点击Home键并不会调用viewWillDisappear
 -[UIViewControllerTestVC viewWillDisappear:]  // push到下一个界面，会调用viewWillDisappear、viewDidDisappear，但不会调用dealloc
 -[UIViewControllerTestVC viewDidDisappear:]
 -[UIViewControllerTestVC dealloc]
 */
@interface LMJLifeCycleViewController : LMJStaticTableViewController

@end
