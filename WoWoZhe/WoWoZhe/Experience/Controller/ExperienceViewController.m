//
//  ExperienceViewController.m
//  WoWoZhe
//
//  Created by MS on 15/10/22.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "ExperienceViewController.h"
#import "XHTopScrollView.h"

#define xh_ScoHeight 40.0f
#define xh_size [UIScreen mainScreen].bounds.size

#define K_TM_SX_Url @"http://sapi.beibei.com/resource/ads-iPhone-2147483646-App%20Store-1_3_4_5_6_7_19_22_42_28_36_43-3.3.1-0.html"
#define K_TM_TZ_Url @"http://sapi.beibei.com/martshow/search/1-30-dress---0-1.html"
#define K_TM_TX_Url @"http://sapi.beibei.com/martshow/search/%d-30-shoes---0-1.html"
#define K_TM_YP_Url @"http://sapi.beibei.com/martshow/search/%d-30-babythings---0-1.html"
#define K_TM_WJ_Url @"http://sapi.beibei.com/martshow/search/%d-30-toy---0-1.html"
#define K_TM_NZ_Url @"http://sapi.beibei.com/martshow/search/%d-30-woman_dress---0-1.html"
#define K_TM_JJ_Url @"http://sapi.beibei.com/martshow/search/%d-30-house---0-1.html"
#define K_TM_SP_Url @"http://sapi.beibei.com/martshow/search/%d-30-food---0-1.html"
#define K_TM_MZ_Url @"http://sapi.beibei.com/martshow/search/%d-30-beauty---0-1.html"
#define K_TM_XQ_Url @"http://sapi.beibei.com/martshow/search/%d-30-tomorrow---0-1.html"




@interface ExperienceViewController ()


@end

@implementation ExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //我擦，，，我终于找到你这个牛逼的，，无与伦比的代码了。。。。。。。。。。。。。。。。。。。。。。。
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"经验";
    [self createUI];
    
}

- (void)createUI {
    NSArray *btnArr  = @[@"上新",@"童装",@"童鞋",@"用品",@"玩具",@"女装",@"居家",@"食品",@"美妆",@"下期预告"];
    NSMutableArray *vcArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < btnArr.count; i++) {
        [vcArr addObject:@"SubViewController"];
    }
    NSArray *urlArr = @[K_TM_SX_Url, K_TM_TZ_Url, K_TM_TX_Url, K_TM_YP_Url, K_TM_WJ_Url, K_TM_NZ_Url, K_TM_JJ_Url, K_TM_SP_Url, K_TM_MZ_Url, K_TM_XQ_Url];
    
    
    XHTopScrollView *scrollView = [[XHTopScrollView alloc]initWithFrame:CGRectMake(0, 64, xh_size.width, xh_size.height-64-49) TitleArr:btnArr ViewcontrollerNameArr:vcArr urlStrArr:urlArr];
    //刷新数据。。。。。。
    scrollView.XHTopScrBlock = ^(UIViewController *vc ,NSString *urlStr){
        [(SubViewController *)vc reloadData:urlStr];
    };
        
    [self.view addSubview:scrollView];
}





















@end
