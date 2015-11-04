//
//  BaseViewController.h
//  WoWoZhe
//
//  Created by MS on 15/10/22.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

//lib
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "HLManager.h"


//controller
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "SubViewController.h"

//model
#import "FirstModel.h"
#import "menuModel.h"
#import "sliderModel.h"

#import "categaryModel.h"

//view
#import "FirstViewCell.h"
#import "SliderCollectionViewCell.h"
#import "MenuCollectionViewCell.h"

#import "CategaryCollectionViewCell.h"

//size
#define SIZE [UIScreen mainScreen].bounds.size
//

//single
#import "SingleUrl.h"

@interface BaseViewController : UIViewController

@end
