//
//  WeakWebViewScriptMessageDelegate.h
//  AllInCode
//
//  Created by hd on 2021/4/19.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WKScriptMessageHandler.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>

//WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
