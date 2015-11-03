//
//  HLConnection.h
//  LoveFree
//
//  Created by huanghailong on 15/9/25.
//  Copyright (c) 2015年 huanghailong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLConnection : NSObject <NSURLConnectionDataDelegate> {
    NSURLConnection *_uc;
}

@property (nonatomic, strong) NSString      *urlStr;
@property (nonatomic, strong) NSMutableData *downloadData;
@property (nonatomic, assign) id            target;
@property (nonatomic, assign) SEL           action;
@property (nonatomic, assign) NSInteger     tag;
@property (nonatomic, assign) BOOL          isSuccess;

//构造
- (id)initWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag;

//类方法创建对象
+ (instancetype)hlConnectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag;
+ (instancetype)hlConnectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action;

//开始和停止
- (void)start;
- (void)stop;

@end







