//
//  SubViewController.h
//  WoWoZhe
//
//  Created by xiaohan on 15/11/4.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewController : UIViewController

@property (nonatomic,copy) NSString *urlStr;


- (void)reloadData:(NSString *)urlStr;


@end
