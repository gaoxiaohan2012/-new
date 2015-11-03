//
//  HLManager.m
//  LoveFree
//
//  Created by huanghailong on 15/9/25.
//  Copyright (c) 2015年 huanghailong. All rights reserved.
//

#import "HLManager.h"

@implementation HLManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (instancetype)defaultManager {
    static HLManager *hm = nil;
    @synchronized(self) {
        if (!hm) {
            hm = [[HLManager alloc] init];
        }
    }
    return hm;
}

- (void)startConnectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag {
    HLConnection *hc = [_dataDic objectForKey:urlStr];
    if (hc) {
        NSLog(@"提交了一个重复的网络请求");
        return;
    }
    hc = [HLConnection hlConnectionWithUrlStr:urlStr target:target action:action tag:tag];
    [hc start];
}

- (void)insertConnection:(HLConnection *)hc {
    [_dataDic setObject:hc forKey:hc.urlStr];
}

- (void)deleteConnection:(HLConnection *)hc {
    [_dataDic removeObjectForKey:hc.urlStr];
}

- (void)stopAllConnetionForTarget:(id)target {
    for (NSString *keyStr in _dataDic) {
        HLConnection *hc = [_dataDic objectForKey:keyStr];
        if (hc.target == target) {
            [hc stop];
        }
    }
}

@end






