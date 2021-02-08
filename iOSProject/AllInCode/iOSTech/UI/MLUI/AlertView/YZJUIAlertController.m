//
//  YZJUIAlertController.m
//  AllInCode
//
//  Created by hd on 2021/1/29.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJUIAlertController.h"


@implementation YZJUIAlertController
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建UIAlertControler
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"这是一些信息" preferredStyle:UIAlertControllerStyleAlert];
    /*
     参数说明：
     Title:弹框的标题
     message:弹框的消息内容
     preferredStyle:弹框样式：UIAlertControllerStyleAlert
     */
    
    //2.添加按钮动作
    //2.1 确认按钮
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确认按钮");
    }];
    //2.2 取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    //2.3 还可以添加文本框 通过 alert.textFields.firstObject 获得该文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请填写您的反馈信息";
    }];
 
    //3.将动作按钮 添加到控制器中
    [alert addAction:conform];
    [alert addAction:cancel];
    
    //4.显示弹框
    [self presentViewController:alert animated:YES completion:nil];
}


@end
