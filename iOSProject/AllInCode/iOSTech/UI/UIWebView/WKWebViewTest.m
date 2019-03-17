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
    
    // 刷新按钮
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBarButtonDidClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    self.url = @"https://0000049-wfm.dev.owsgo.com/Reports?username=I6mkuLbvkvc50ybR3WPEug==&logonflag=i4xLoD72wwzurf4Qts+msRSFY5n2nyUrE3H9WSUaO0o=&logonState=Y";
//    self.url = @"https://www.baidu.com";
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
