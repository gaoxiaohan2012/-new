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

@interface ExperienceViewController ()


@end

@implementation ExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //我擦，，，我终于找到你这个牛逼的，，无与伦比的代码了。。。。。。。。。。。。。。。。。。。。。。。
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    
}

- (void)createUI {
    NSArray *btnArr  = @[@"问你",@"你是",@"他们",@"fefe",@"安慰",@"俄方",@"分瓦ff房",@"费瓦",@"分瓦房",@"范围广",@"few"];
    NSMutableArray *vcArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < btnArr.count; i++) {
        [vcArr addObject:@"SubViewController"];
    }
    
    
    XHTopScrollView *scrollView = [[XHTopScrollView alloc]initWithFrame:CGRectMake(0, 64, xh_size.width, xh_size.height-64-49) TitleArr:btnArr ViewcontrollerNameArr:vcArr];
        
    [self.view addSubview:scrollView];
}























@end
