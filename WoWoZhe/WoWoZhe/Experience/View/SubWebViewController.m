//
//  SubWebViewController.m
//  WoWoZhe
//
//  Created by xiaohan on 15/11/7.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "SubWebViewController.h"

@interface SubWebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    BOOL _isReload;
    NSString *_urlStr;
}
@end

//@"http://3g.163.com/sports/15/1106/20/B7OVCURU00051CCL.html"

@implementation SubWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_webView];
    [self reloadData];
}
- (void)reloadWebView:(NSString *)urlStr {
    _urlStr = urlStr;
    [self reloadData];
}
- (void)reloadData {
    //数据没加载成功，就加载。
    if (!_isReload) {
        if (_urlStr) {
            NSURL *url = [NSURL URLWithString:_urlStr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            _webView.scalesPageToFit = YES;
            _webView.delegate = self;
            [_webView loadRequest:request];
            [_webView reload];
        }
    }
}

#pragma mark -- delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _isReload = YES;
}







@end
