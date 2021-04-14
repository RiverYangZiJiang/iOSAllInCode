//
//  LMJWordArrowItem.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/11.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJWordArrowItem.h"

@implementation LMJWordArrowItem
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVc:(NSString *)destVc
{
    LMJWordArrowItem *item = [super itemWithTitle:title subTitle:subTitle];
    item.destVc = NSClassFromString(destVc);
    return item;
}
@end
