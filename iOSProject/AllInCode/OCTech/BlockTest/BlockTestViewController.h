//
//  BlockTestViewController.h
//  OCTest
//
//  Created by 杨子江 on 11/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 block块可理解为可以做参数的特殊函数，只不过定义语法格式和函数不完全一样。block可以像函数一样单独调用；也可以作为函数形参，让用户去实现这个block，这样在函数执行完某些操作之后再回调该block
 Blocks are Objective-C objects，使用block可以简化OC编程。以下是定义block的基本语法格式，在snippet输入block即可得到其格式
 <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
 <#statements#>
 };
 */

//typedef <#returnType#>(^<#name#>)(<#arguments#>);
// 作为形参的block类型
typedef void(^GetCapitalNameBlock)(NSString *name);
@interface BlockTestViewController : LMJStaticTableViewController

@end
