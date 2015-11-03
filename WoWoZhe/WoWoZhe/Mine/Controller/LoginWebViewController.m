//
//  LoginWebViewController.m
//  WoWoZhe
//
//  Created by xiaohan on 15/10/27.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "LoginWebViewController.h"
#import "AFNetworking.h"
#import "SingleUrl.h"
@interface LoginWebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation LoginWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _urlStr = @"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=http://";
    _client_id = @"762805224";
    NSString *url = [NSString stringWithFormat:_urlStr,_client_id];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    
}

#pragma mark -- delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    

    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        NSString *urlStr = [url substringFromIndex:range.location + range.length];
       // MYLog(@"%@",urlStr);
        [self accessTokenWithCode:urlStr];
    }
    
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *accessToken = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    bodyDic[@"client_id"] = @"762805224";
    bodyDic[@"client_secret"] = @"443062179d9ab519955073497de26c19";
    bodyDic[@"grant_type"] = @"authorization_code";
    bodyDic[@"redirect_uri"] = @"http://";
    bodyDic[@"code"] = code;
    
    [manager POST:accessToken parameters:bodyDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        [SingleUrl shareUrl].urlStr = [dic objectForKey:@"access_token"];
        NSLog(@"%@",[SingleUrl shareUrl].urlStr);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

















@end
