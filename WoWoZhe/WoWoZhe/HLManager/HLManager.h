//
//  HLManager.h
//  LoveFree
//
//  Created by huanghailong on 15/9/25.
//  Copyright (c) 2015年 huanghailong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLConnection.h"

@interface HLManager : NSObject {
    NSMutableDictionary *_dataDic;
}

//获取单例对象的方法
+ (instancetype)defaultManager;

//启动一个网络请求
- (void)startConnectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag;

//添加和删除记录
- (void)insertConnection:(HLConnection *)hc;
- (void)deleteConnection:(HLConnection *)hc;

//停止某个对象所有的网络请求
- (void)stopAllConnetionForTarget:(id)target;

@end






