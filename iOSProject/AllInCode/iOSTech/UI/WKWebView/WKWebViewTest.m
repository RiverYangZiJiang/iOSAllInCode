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

@interface WKWebViewTest ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
/// 是否加载完成
@property (nonatomic, assign) BOOL loadingCompletion;
/**
 进度条
 */
@property (nonatomic,strong) UIProgressView *progress;


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
    // ------ 移除观察者
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)setupUI{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progress];
    [self.view bringSubviewToFront:self.progress];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(Nav_Height);
    }];
    // 刷新按钮
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBarButtonDidClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
//    self.url = @"https://www.baidu.com";
    self.url = self.url ? :  @"https:\/\/ad-h5.fcb.com.cn\/makePost\/index.html#\/page?jsUrl=4yuebdw01&channel=8621&groupId=30a6b37e0f2cea20462da646f0af545e&utm_campaign=4yuebdw01&utm_content=8621&utm_source=30a6b37e0f2cea20462da646f0af545e&activityNo=";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    //TODO:kvo监听，获得页面和加载进度值
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
/**
 刷新

 @param rightBarButtonItem <#rightBarButtonItem description#>
 */
- (void)rightBarButtonDidClicked:(UIBarButtonItem *)rightBarButtonItem{
    [self.webView reload];
}

/**
 *  在发送请求之前，决定是否跳转，即是否会打开新的WKWebView
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    /* 判断itunes的host链接，如果包含则跳转到App Store对应App下载界面，如itms-apps://itunes.apple.com/app/id1527360518 */
    NSURL *url = navigationAction.request.URL;
    DLog(@"url.absoluteString: %@", url.absoluteString);
    if([[url host] isEqualToString:@"itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:^(BOOL success) {
            DLog(@"");
        }];
        decisionHandler(WKNavigationActionPolicyCancel);  // 不跳转
        return;
    }else if (![url.scheme hasPrefix:@"http"]) {  // 非http开头的不跳转，打开一些页面会跳转多次，其url为"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"格式，表示最小的base64透明图片，大小为 1px * 1px
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
    DLog(@"self.loadingCompletion: %d", self.loadingCompletion);
    if (self.loadingCompletion) {
        decisionHandler(WKNavigationResponsePolicyCancel);
    } else {
        decisionHandler(WKNavigationResponsePolicyAllow);
        self.loadingCompletion = YES;
    }
}

#pragma mark - KVO
#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == self.webView)
        {
            NSLog(@"%s, self.webView.estimatedProgress = %f", __func__, self.webView.estimatedProgress);
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5f
                                      delay:0.3f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self.progress setAlpha:0.0f];
                                 }
                                 completion:^(BOOL finished) {
                                     [self.progress setProgress:0.0f animated:NO];
                                 }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //网页title
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

- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *vc = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:vc];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

#pragma mark 加载进度条
- (UIProgressView *)progress
{
    if (_progress == nil)
    {
        NSLog(@"%s", __func__);
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 44 + [UIApplication sharedApplication].statusBarFrame.size.height, CGRectGetWidth(self.view.frame), 2)];
        _progress.tintColor = [UIColor blueColor];
        _progress.backgroundColor = [UIColor lightGrayColor];
    }
    return _progress;
}

@end
