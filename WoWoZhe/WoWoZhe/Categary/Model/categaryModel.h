//
//  categaryModel.h
//  WoWoZhe
//
//  Created by xiaohan on 15/10/25.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface categaryModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *id;

@property (nonatomic,strong) NSArray *categaryArr;

@end
