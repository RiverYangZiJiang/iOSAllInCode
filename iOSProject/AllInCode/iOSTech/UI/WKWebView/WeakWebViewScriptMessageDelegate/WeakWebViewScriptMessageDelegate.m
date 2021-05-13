//
//  WeakWebViewScriptMessageDelegate.m
//  AllInCode
//
//  Created by hd on 2021/4/19.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "WeakWebViewScriptMessageDelegate.h"

@implementation WeakWebViewScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

#pragma mark - WKScriptMessageHandler
//遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
//通过接收JS传出消息的name进行捕捉的回调方法
// message.body Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
