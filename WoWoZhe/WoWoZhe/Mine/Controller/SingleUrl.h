//
//  SingleUrl.h
//  WoWoZhe
//
//  Created by MS on 15/10/28.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleUrl : NSObject
@property (nonatomic,copy) NSString *urlStr;
+ (instancetype)shareUrl;

@end
