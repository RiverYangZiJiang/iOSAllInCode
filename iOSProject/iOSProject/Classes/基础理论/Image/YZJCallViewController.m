//
//  YZJCallViewController.m
//  iOSProject
//
//  Created by yangzijiang on 2018/8/10.
//  Copyright © 2018 github.com/njhu. All rights reserved.
//

#import "YZJCallViewController.h"

@interface YZJCallViewController ()

@end

@implementation YZJCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // https://www.jianshu.com/p/589609124c97
    // 1.创建单元格cell
    LMJWordItem *item0 = [LMJWordItem itemWithTitle:@"loadRequest(推荐使用)" subTitle:@"拨打前弹出提示，拨打完以后会回到原来的应用。" itemOperation:^(NSIndexPath *indexPath) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"10086"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }];
    
    LMJWordItem *item1 = [LMJWordItem itemWithTitle:@"openURL(telprompt)" subTitle:@"拨打前弹出提示，拨打完以后会回到原来的应用。" itemOperation:^(NSIndexPath *indexPath) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"10086"];
        NSURL *url = [NSURL URLWithString:str];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
            //设备系统为IOS 10.0或者以上的
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }else{
            //设备系统为IOS 10.0以下的
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    
    LMJWordItem *item2 = [LMJWordItem itemWithTitle:@"openURL(tel)" subTitle:@"拨打前弹出提示，拨打完以后会回到原来的应用。" itemOperation:^(NSIndexPath *indexPath) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"10086"];
        NSURL *url = [NSURL URLWithString:str];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
            //设备系统为IOS 10.0或者以上的
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }else{
            //设备系统为IOS 10.0以下的
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    
    // 2.创建节section
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item0, item1, item2] andHeaderTitle:@"Header" footerTitle:@"备注：\n1.在iOS10之后再用openURL: 的方法拨打电话会有1-2秒的延迟时间，iOS10之后使用openURL: options: completionHandler:的API可以解决延迟问题。\n2.此openURL: options: completionHandler:方法API在iOS11下测试情况：拨打前弹出提示， and, 拨打完以后会回到原来的应用。"];
    
    // 3.添加节到节数组
    [self.sections addObject:section0];
}


@end
