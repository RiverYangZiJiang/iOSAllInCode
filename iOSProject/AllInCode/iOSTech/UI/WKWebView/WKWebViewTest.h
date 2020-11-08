//
//  WKWebViewTest.h
//  iosTest2017
//
//  Created by yangzijiang on 2018/10/25.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewTest : UIViewController

/**
 1.同样的HTML，在WKWebView中显示的字体比UIWebView中的小。
 解决方案：WKWebView 可以通过配置文件设置字体大小：
 
 WKWebview是任何应用程序的最佳选择，因为它具有对旧版本的Webview（UIWebView）的许多改进。 这些功能包括：
 
 2.ionic3 从UIWebView升级到WKWebView（翻译）
 JIT将JS代码转换为机器代码，运行速度更快
 改善了渲染性能
 减少内存消耗
 更好地遵守网络标准
 可靠的滚动事件（对虚拟列表很重要）
 
 1.同样的HTML，在WKWebView中显示的字体比UIWebView中的小。https://segmentfault.com/q/1010000010971196/a-1020000010982716
 2.ionic3 从UIWebView升级到WKWebView（翻译） https://www.jianshu.com/p/1648ac581906
 3.WKWebView【关于WKWebViewx非常详尽的使用，如标题、刷新按钮、显示加载进度条】 https://www.jianshu.com/p/35be2053111c
 4.WKWebView获取页面title和加载进度值 https://www.jianshu.com/p/6f2d733502c6
 
 */

@property (copy, nonatomic) NSString *url;
@end

NS_ASSUME_NONNULL_END
