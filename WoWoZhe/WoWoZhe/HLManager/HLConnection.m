//
//  HLConnection.m
//  LoveFree
//
//  Created by huanghailong on 15/9/25.
//  Copyright (c) 2015年 huanghailong. All rights reserved.
//

#import "HLConnection.h"
#import <UIKit/UIKit.h>
#import "HLManager.h"

@implementation HLConnection

- (id)initWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag {
    if (self = [super init]) {
        self.urlStr = urlStr;
        self.target = target;
        self.action = action;
        self.tag = tag;
        NSLog(@"urlStr = %@", urlStr);
    }
    return self;
}

+ (instancetype)hlConnectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag {
    return [[HLConnection alloc] initWithUrlStr:urlStr target:target action:action tag:tag];
}

+ (instancetype)hlConnectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action {
    return [HLConnection hlConnectionWithUrlStr:urlStr target:target action:action tag:0];
}

- (void)start {
    _downloadData = [[NSMutableData alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr] cachePolicy:0 timeoutInterval:15];
    _uc = [NSURLConnection connectionWithRequest:request delegate:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //让网络管理对象记录自己
    [[HLManager defaultManager] insertConnection:self];
}

- (void)stop {
    [_uc cancel];
    
    //删除记录
    [[HLManager defaultManager] deleteConnection:self];
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _downloadData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_downloadData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.isSuccess = YES;
    [self.target performSelector:self.action withObject:self afterDelay:0];
     [[HLManager defaultManager] deleteConnection:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.isSuccess = NO;
    [self.target performSelector:self.action withObject:self afterDelay:0];
     [[HLManager defaultManager] deleteConnection:self];
}

- (void)dealloc {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end









