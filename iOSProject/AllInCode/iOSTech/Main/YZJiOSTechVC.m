//
//  YZJiOSTechVC.m
//  iOSAllInCode
//
//  Created by 杨子江 on 3/10/19.
//  Copyright © 2019 杨子江. All rights reserved.
//

#import "YZJiOSTechVC.h"
#import "YZJViewController.h"
#import "YZJUIViewController.h"
#import "YZJMultiMedia_HardWareVC.h"
#import "WKWebViewTest.h"
#import "UICollectionViewVC.h"
#import "YZJAnimationVC.h"
#import "JMViewController.h"
#import "YZJUILabelVC.h"
#import "YZJUIViewVC.h"
#import "UIImageTestVC.h"
#import "UITableViewControllerTest.h"
#import "YZJUITextFieldVC.h"

@interface YZJiOSTechVC ()

@end

@implementation YZJiOSTechVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    // 表格底部往上移ttabBar的高度
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.height;
    self.tableView.contentInset = edgeInsets;
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"MLUI" subTitle:@"自定义UI"];
    item00.destVc = [YZJUIViewController class];
    
    LMJWordArrowItem *item01 = [LMJWordArrowItem itemWithTitle:@"UIViewController" subTitle:@"控制器测试"];
    item01.destVc = [YZJViewController class];
    
    LMJWordArrowItem *item02= [LMJWordArrowItem itemWithTitle:@"YZJMultiMedia_HardWareVC" subTitle:@""];
    item02.destVc = [YZJMultiMedia_HardWareVC class];
    
    LMJWordArrowItem *item03= [LMJWordArrowItem itemWithTitle:@"WKWebView" subTitle:@""];
    item03.destVc = [WKWebViewTest class];
    LMJWordArrowItem *item04= [LMJWordArrowItem itemWithTitle:@"UICollectionViewVC" subTitle:@""];
    item04.destVc = [UICollectionViewVC class];
    
    LMJWordArrowItem *item05= [LMJWordArrowItem itemWithTitle:@"动画-画图" subTitle:@""];
    item05.destVc = [YZJAnimationVC class];
    
    LMJWordArrowItem *item06= [LMJWordArrowItem itemWithTitle:@"UIButton" subTitle:@""];
    item06.destVc = [JMViewController class];
    
    LMJWordArrowItem *item07= [LMJWordArrowItem itemWithTitle:@"UILabel-倒计时" subTitle:@""];
    item07.destVc = [YZJUILabelVC class];
    
    LMJWordArrowItem *item08= [LMJWordArrowItem itemWithTitle:@"UIView" subTitle:@"圆角"];
    item08.destVc = [YZJUIViewVC class];
    
    LMJWordArrowItem *item09= [LMJWordArrowItem itemWithTitle:@"UIImageView" subTitle:@""];
    item09.destVc = [UIImageTestVC class];
    
    LMJWordArrowItem *item10= [LMJWordArrowItem itemWithTitle:@"UITableViewController" subTitle:@"" destVc:@"UITableViewControllerTest"];
    
    LMJWordArrowItem *item11 = [LMJWordArrowItem itemWithTitle:@"UITextField" subTitle:@"" destVc:@"YZJUITextFieldVC"];
    
    LMJWordArrowItem *item12 = [LMJWordArrowItem itemWithTitle:@"UIScrollViewVC" subTitle:@"" destVc:@"UIScrollViewVC"];
    
    LMJWordArrowItem *item13 = [LMJWordArrowItem itemWithTitle:@"UIImagePickerController" subTitle:@"选择图片-拍照" destVc:@"UIImagePickerControllerVC"];
    
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00, item01, item02, item03, item04, item05, item06, item07, item08, item09, item10, item11, item12, item13] andHeaderTitle:@"UI" footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
}

@end
