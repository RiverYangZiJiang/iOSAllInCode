//
//  YZJWebViewCallViewController.m
//  iOSProject
//
//  Created by yangzijiang on 2018/8/10.
//  Copyright © 2018 github.com/njhu. All rights reserved.
//

#import "YZJWebViewCallViewController.h"

@interface YZJWebViewCallViewController ()

@end

@implementation YZJWebViewCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"call" ofType:@"html"];
    NSURL *url = [NSURL URLWithString:htmlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets padding = UIEdgeInsetsMake(60, 10, 10, 10);
        make.edges.equalTo(self.view).insets(padding);
    }];
}


@end
