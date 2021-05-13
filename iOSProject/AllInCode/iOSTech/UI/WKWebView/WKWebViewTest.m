//
//  WKWebViewTest.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/10/25.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "WKWebViewTest.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
#import "CPButton.h"
#import "WeakWebViewScriptMessageDelegate.h"

@interface WKWebViewTest ()<WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;
/// 是否加载完成
@property (nonatomic, assign) BOOL loadingCompletion;
/**
 进度条
 */
@property (nonatomic,strong) UIProgressView *progressView;

/// 第一个界面decidePolicyForNavigationResponse后的时间，第二个界面请求在1秒之内，则不跳转，解决打开恒房通、感恩有你等页面多次跳转的问题
@property (nonatomic, strong) NSDate *firstPageDate;

/// 底部容纳后退、前进、刷新、首页按钮
@property (nonatomic, strong) UIView *bottomContainerView;
///
@property (nonatomic, strong) CPButton *backButton;
///
@property (nonatomic, strong) CPButton *forwardButton;
///
@property (nonatomic, strong) CPButton *refreshButton;
///
@property (nonatomic, strong) CPButton *homeButton;

@end

@implementation WKWebViewTest

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%s", __func__);
    [super viewWillAppear:animated];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    //移除注册的js方法，否则addScriptMessageHandler很容易引起循环引用，导致控制器无法被释放
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcNoPrams"];
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcWithPrams"];
    
    // ------ 移除观察者
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)setupUI{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self.view bringSubviewToFront:self.progressView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(Nav_Height);
    }];
    // 刷新按钮
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBarButtonDidClicked:)];
    UIBarButtonItem * ocToJs = [[UIBarButtonItem alloc] initWithTitle:@"OC调用JS" style:UIBarButtonItemStyleDone target:self action:@selector(ocToJs)];
    self.navigationItem.rightBarButtonItems = @[rightBarButtonItem, ocToJs];
    
    //TODO:kvo监听，获得页面和加载进度值
    // 添加监测网页加载进度的观察者
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    // 添加监测网页标题title的观察者
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self.view addSubview:self.bottomContainerView];
    [self.bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(SafeAreaBottomHeight + 44);
    }];
    NSArray<CPButton *> *array = @[self.backButton, self.forwardButton, self.refreshButton, self.homeButton];
    
    CGFloat buttonW = ScreenWidth / array.count;
    [array enumerateObjectsUsingBlock:^(CPButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.bottomContainerView addSubview:obj];
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bottomContainerView).offset(idx * buttonW);
                make.width.mas_equalTo(buttonW);
                make.top.bottom.equalTo(self.bottomContainerView);
            }];
    }];
    
    //    self.url = @"https://www.baidu.com";
//        self.url = self.url ? :  @"https:\/\/ad-h5.fcb.com.cn\/makePost\/index.html#\/page?jsUrl=4yuebdw01&channel=8621&groupId=30a6b37e0f2cea20462da646f0af545e&utm_campaign=4yuebdw01&utm_content=8621&utm_source=30a6b37e0f2cea20462da646f0af545e&activityNo=";
//        self.url = self.url ? : @"https://forms.ebdan.net/ls/9LzohiFC";
    
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [self loadLocalHtmlFile];
    
}
/**
 刷新

 @param rightBarButtonItem <#rightBarButtonItem description#>
 */
- (void)rightBarButtonDidClicked:(UIBarButtonItem *)rightBarButtonItem{
    [self.webView reload];
}

#pragma mark - Delegates
#pragma mark -- WKScriptMessageHandler
// 注意：遵守WKScriptMessageHandler协议，代理是由WKUserContentControl设置
// 通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //用message.body获得JS传出的参数体
    NSDictionary * parameter = message.body;
    //JS调用OC
    if([message.name isEqualToString:@"jsToOcNoPrams"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:@"不带参数" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if([message.name isEqualToString:@"jsToOcWithPrams"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:parameter[@"params"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

// OC调用JS
- (void)ocToJs{
    //changeColor()是JS方法名，completionHandler是异步回调block
    NSString *jsString = [NSString stringWithFormat:@"changeColor('%@')", @"Js颜色参数"];
    [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"改变HTML的背景色");
    }];
    
    //改变字体大小 调用原生JS方法
    NSString *jsFont = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", arc4random()%99 + 100];
    [_webView evaluateJavaScript:jsFont completionHandler:nil];
    
    NSString * path =  [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"png"];
    NSString *jsPicture = [NSString stringWithFormat:@"changePicture('%@','%@')", @"pictureId",path];
    [_webView evaluateJavaScript:jsPicture completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"切换本地头像");
    }];
    
}
#pragma mark -- WKNavigationDelegate
/**
 *  在发送请求之前，决定是否跳转到新界面
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 解决使用多个控制器打开网页时，页面会多次调用decidePolicyForNavigationAction方法，导致打开一个界面会多次跳转，url可能以data开头或http开头。WKWebView或Safari默认情况下并不会打开多个页面
    if (self.firstPageDate) {
        NSDate *date = [NSDate date];
        CGFloat timePassed = [date timeIntervalSinceDate:self.firstPageDate];
        DLog(@"timePassed: %f", timePassed);
        if (timePassed < 1.0) {
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    /* 判断itunes的host链接，如果包含则跳转到App Store对应App下载界面，如itms-apps://itunes.apple.com/app/id1527360518 */
    NSURL *url = navigationAction.request.URL;
    DLog(@"url.absoluteString: %@", url.absoluteString);
    if([[url host] isEqualToString:@"itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:^(BOOL success) {
            DLog(@"");
        }];
        decisionHandler(WKNavigationActionPolicyCancel);  // 不跳转
        return;
    }else if (!([url.scheme hasPrefix:@"http"] || [url.scheme hasPrefix:@"file"])) {  // 非http或file开头的不跳转，打开一些页面会跳转多次，其url为"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"格式，表示最小的base64透明图片，大小为 1px * 1px
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if (self.loadingCompletion) {
        // 可以在此控制push到一个新的包含WkWebview的控制器，这样实现每个界面用一个WkWebview显示的功能，类似小程序的实现
        WKWebViewTest *vc = [[WKWebViewTest alloc] init];
        vc.url = url.absoluteString;
        [self.navigationController pushViewController:vc animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);  // 本界面不跳转，而是打开新的控制器
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    if (!self.firstPageDate) {  // 如果网速慢，则响应时间会比较长，所以在响应里面记录第一个页面完成的时间
        self.firstPageDate = [NSDate date];
    }
    DLog(@"self.loadingCompletion: %d", self.loadingCompletion);
    if (self.loadingCompletion) {  // 打开其他页面时，本界面不跳转
        decisionHandler(WKNavigationResponsePolicyCancel);
    } else
    {
        decisionHandler(WKNavigationResponsePolicyAllow);
//        decisionHandler(WKNavigationResponsePolicyCancel);  // 打开页面时空白
        self.loadingCompletion = YES;
    }
}

/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self getCookie];
    NSLog(@"%s", __func__);
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
    NSLog(@"%s", __func__);
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

//// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//    NSString * urlStr = navigationAction.request.URL.absoluteString;
//    NSLog(@"发送跳转请求：%@",urlStr);
//    //自己定义的协议头
//    NSString *htmlHeadString = @"github://";
//    if([urlStr hasPrefix:htmlHeadString]){
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//        }])];
//        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
//            [[UIApplication sharedApplication] openURL:url];
//
//        }])];
//        [self presentViewController:alertController animated:YES completion:nil];
//
//        decisionHandler(WKNavigationActionPolicyCancel);
//
//    }else{
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//}

//// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    NSString * urlStr = navigationResponse.response.URL.absoluteString;
//    NSLog(@"当前跳转地址：%@",urlStr);
//    //允许跳转
//    decisionHandler(WKNavigationResponsePolicyAllow);
//    //不允许跳转
//    //decisionHandler(WKNavigationResponsePolicyCancel);
//}

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    NSLog(@"%s", __func__);
    //用户身份信息
    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
    //为 challenge 的发送方提供 credential
    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
    
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"%s", __func__);
}

#pragma mark - WKUIDelegate主要处理JS脚本，确认框，警告框等
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 确认框
//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 输入框
//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == self.webView)
        {
            NSLog(@"%s, self.webView.estimatedProgress = %f", __func__, self.webView.estimatedProgress);
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5f
                                      delay:0.3f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progressView setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progressView setProgress:0.0f animated:NO];
                                 }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //网页title，title可能会有多个
    else if ([keyPath isEqualToString:@"title"])
    {
        NSLog(@"%s, self.webView.title = %@", __func__, self.webView.title);
        if (object == self.webView)
        {
            self.title = self.webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Private
// 返回历史页面，step为0表示首页
- (void)backPageStep:(NSInteger)step {
    // 可返回的页面列表, 存储已打开过的网页
    WKBackForwardList *backForwardList = [self.webView backForwardList];
    WKBackForwardListItem *backItem = backForwardList.backList[step];
    [self.webView goToBackForwardListItem:backItem];
}

/// 加载本地html文件
- (void)loadLocalHtmlFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC.html" ofType:nil];
    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  //加载本地html文件
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

//解决 页面内跳转（a标签等）还是取不到cookie的问题
- (void)getCookie{
    //取出cookie
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //js函数
    NSString *JSFuncString =
    @"function setCookie(name,value,expires)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }\
    function getCookie(name)\
    {\
    var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
    if(arr != null) return unescape(arr[2]); return null;\
    }\
    function delCookie(name)\
    {\
    var exp = new Date();\
    exp.setTime(exp.getTime() - 1);\
    var cval=getCookie(name);\
    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
    }";
    
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
        [JSCookieString appendString:excuteJSString];
    }
    //执行js
    [_webView evaluateJavaScript:JSCookieString completionHandler:nil];
    
}
#pragma mark - Getters & Setters
- (WKWebView *)webView{
    if (!_webView) {
        //　创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];

        // 创建设置对象WKPreferences
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        // 是使用h5的视频播放器在线播放YES, 还是使用原生播放器全屏播放NO The default value for iPhone is false and the default value for iPad is true.
        config.allowsInlineMediaPlayback = YES;
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        config.requiresUserActionForMediaPlayback = YES;
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        config.applicationNameForUserAgent = @"ChinaDailyForiPad";
         //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //这个类主要用来做native与JavaScript的交互管理，js要想调用OC方法，必须实现本步骤
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //注册一个name为jsToOcNoPrams的js方法，设置处理接收JS方法的代理
        // 可以定义一个公共的name，然后在返回的message.body里去解析对应的方法名称/参数/回调函数名，这样就不用多次调用addScriptMessageHandler方法
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcNoPrams"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"];
       config.userContentController = wkUController;
        
        
        // WKUserScript：用于进行JavaScript注入
        // 以下代码适配文本大小，由UIWebView换为WKWebView后，会发现字体小了很多，这应该是WKWebView与html的兼容问题，解决办法是修改原网页，要么我们手动注入JS
            NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
            // 用于进行JavaScript注入
            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            [config.userContentController addUserScript:wkUScript];

        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _webView.navigationDelegate = self;  // 导航代理
        _webView.UIDelegate = self;  // UI代理
        _webView.allowsBackForwardNavigationGestures = YES;  // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        
    }
    return _webView;
}

- (UIProgressView *)progressView
{
    if (_progressView == nil)
    {
        NSLog(@"%s", __func__);
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 44 + [UIApplication sharedApplication].statusBarFrame.size.height, CGRectGetWidth(self.view.frame), 2)];
        _progressView.tintColor = [UIColor blueColor];
        _progressView.backgroundColor = [UIColor lightGrayColor];
    }
    return _progressView;
}

- (UIView *)bottomContainerView {
    if (!_bottomContainerView) {
        _bottomContainerView = [[UIView alloc] init];
        _bottomContainerView.backgroundColor = [UIColor colorWithHexString:@"#ECEDEF"];
    }
    return _bottomContainerView;
}

- (CPButton *)backButton {
    if (!_backButton) {
        WeakSelf
        _backButton = [[CPButton alloc] initWithTitle:@"后退" titleColor:[UIColor colorWithHexString:@"#5A6B80"] titleFont:[UIFont PingFangSC_RegularOfSize:12] doneBlock:^(UIButton *button) {
            DLog(@"");
            if ([weakSelf.webView canGoBack]) {
                [weakSelf.webView goBack];
            }
        }];
        
    }
    return _backButton;
}

- (CPButton *)forwardButton {
    if (!_forwardButton) {
        WeakSelf
        _forwardButton = [[CPButton alloc] initWithTitle:@"前进" titleColor:[UIColor colorWithHexString:@"#5A6B80"] titleFont:[UIFont PingFangSC_RegularOfSize:12] doneBlock:^(UIButton *button) {
            DLog(@"");
            if ([weakSelf.webView canGoForward]) {
                [weakSelf.webView goForward];
            }
        }];
        
    }
    return _forwardButton;
}

- (CPButton *)refreshButton {
    if (!_refreshButton) {
        WeakSelf
        _refreshButton = [[CPButton alloc] initWithTitle:@"刷新" titleColor:[UIColor colorWithHexString:@"#5A6B80"] titleFont:[UIFont PingFangSC_RegularOfSize:12] doneBlock:^(UIButton *button) {
            DLog(@"");
            [weakSelf.webView reload];
        }];
        
    }
    return _refreshButton;
}


- (CPButton *)homeButton {
    if (!_homeButton) {
        WeakSelf
        _homeButton = [[CPButton alloc] initWithTitle:@"首页" titleColor:[UIColor colorWithHexString:@"#5A6B80"] titleFont:[UIFont PingFangSC_RegularOfSize:12] doneBlock:^(UIButton *button) {
            DLog(@"");
            [weakSelf backPageStep:0];
        }];
    }
    return _homeButton;
}

@end
