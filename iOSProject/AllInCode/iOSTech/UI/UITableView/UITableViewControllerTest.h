//
//  UITableViewControllerTest.h
//  iosTest2017
//
//  Created by 杨子江 on 4/12/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewControllerTest : UITableViewController

/**
 问题：UITableView整体上移时的解决方案 https://www.jianshu.com/p/cb99a5770c3f
 self.edgesForExtendedLayout = UIRectEdgeNone;
 
 隐藏UITableView不需要的分割线(只显示有行内容的分割线）
 tableView.tableFooterView = [UIView new];//不显示多余的分割线，一行代码搞定，厉害
 https://blog.csdn.net/h_o_w_e/article/details/78289426
 */
@end
