//
//  ExperienceModel.h
//  WoWoZhe
//
//  Created by xiaohan on 15/11/6.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExperienceModel : NSObject

//
@property (nonatomic,copy) NSNumber *count;
@property (nonatomic,copy) NSString *tag;
@property (nonatomic,copy) NSNumber *page_size;
@property (nonatomic,copy) NSNumber *main_img_height;
@property (nonatomic,copy) NSNumber *main_img_width;


//cell的数据
@property (nonatomic,copy) NSNumber *bid;
@property (nonatomic,copy) NSString *brand;
@property (nonatomic,copy) NSString *brand_story;
@property (nonatomic,copy) NSString *buying_info;
@property (nonatomic,copy) NSNumber *event_id;
@property (nonatomic,copy) NSNumber *gmt_begin;
@property (nonatomic,copy) NSNumber *gmt_end;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,copy) NSString *main_img;
@property (nonatomic,copy) NSString *mj_icon;
@property (nonatomic,copy) NSString *mj_promotion;
@property (nonatomic,copy) NSString *promotion;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSNumber *stock;


@end
