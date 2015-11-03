//
//  SingleUrl.m
//  WoWoZhe
//
//  Created by MS on 15/10/28.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "SingleUrl.h"

@implementation SingleUrl

+ (instancetype)shareUrl {
    static SingleUrl *url = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        url = [[self alloc]init];
    });
    return url;
    
//    @synchronized([SingleUrl class]){
//        if (!url) {
//            url = [[SingleUrl alloc]init];
//        }
//    
//    }
//    return url;
}


@end
