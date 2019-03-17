//
//  UINavigationItem+BackItem.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/11/16.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "UINavigationItem+BackItem.h"
#import <objc/runtime.h>

@implementation UINavigationItem (BackItem)
#pragma mark - Method Swizzling：将系统自带的backBarButtonItem方法替换成我们自定义的方法。
// https://www.cnblogs.com/LeoTai/p/5456705.html
+(void)load{
#warning 测试
    return;
    
    NSLog(@"%s", __func__);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethodImp = class_getInstanceMethod(self, @selector(backBarButtonItem));
        Method destMethodImp = class_getInstanceMethod(self, @selector(myCustomBackButton));
        method_exchangeImplementations(originalMethodImp, destMethodImp);
    });
}

static char kCustomBackButtonKey;

-(UIBarButtonItem *)myCustomBackButton{
    NSLog(@"%s", __func__);
    UIBarButtonItem *item = [self myCustomBackButton];
    if (item) {
        return item;
    }
    item = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:NULL];
        objc_setAssociatedObject(self, &kCustomBackButtonKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return item;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    objc_removeAssociatedObjects(self);
}

@end
