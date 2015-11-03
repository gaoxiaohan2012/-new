//
//  MainTabBarController.m
//  Wowozhe
//
//  Created by MS on 15/10/22.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "MainTabBarController.h"
#define k_ScreenSize [UIScreen mainScreen].bounds.size
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//将要出现的时候，，，，创建UI。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createUI];
}

- (void)createUI {
    NSArray *titleArr = @[@"首页",@"分类",@"秒杀",@"经验",@"我的"];
    NSArray *imageArr = @[@"tab_1_gray", @"tab_2_gray", @"tab_3_gray",@"tab_4_gray", @"tab_5_gray"];
    NSArray *selectedImgArr = @[@"tab_1", @"tab_2", @"tab_3", @"tab_4", @"tab_5"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0 , 0 , k_ScreenSize.width, 49)];
    view.userInteractionEnabled = YES;
    
    for (int i = 0; i<titleArr.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*k_ScreenSize.width/5, 0, k_ScreenSize.width/5, 49)];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        button.titleEdgeInsets = UIEdgeInsetsMake(25, 0, 0, 10);
        
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImgArr[i]] forState:UIControlStateSelected];
        button.imageEdgeInsets = UIEdgeInsetsMake(-10, 32, 0, 20);
        
        
        button.tag = 10+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"index"];
        if (i == index) {
            button.selected = YES;
        }
        [view addSubview:button];
    }
    [self.tabBar addSubview:view];
}

- (void)btnClick:(UIButton *)btn {
    for ( int i = 0; i < 5; i++) {
        UIButton *button = (id)[self.view viewWithTag:10+i];
        if (button != btn) {
            button.selected = NO;
        }
    }
    btn.selected = YES;
   
    self.selectedIndex = btn.tag - 10;
    [[NSUserDefaults standardUserDefaults] setInteger:self.selectedIndex forKey:@"index"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
