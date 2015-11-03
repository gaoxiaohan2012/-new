//
//  ExperienceViewController.m
//  WoWoZhe
//
//  Created by MS on 15/10/22.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "ExperienceViewController.h"
#import "XHTopScrollView.h"

#define xh_ScoHeight 30.0f
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
    NSArray *btnArr  = @[@"问你",@"你是",@"他们"];
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    
    NSArray *vcArr = @[vc1,vc2,vc3];
    
    
    XHTopScrollView *scrollView = [[XHTopScrollView alloc]initWithFrame:CGRectMake(0, 64, xh_size.width, xh_ScoHeight) TitleArr:btnArr ViewcontrollerArr:vcArr];
        
    [self.view addSubview:scrollView];
}























@end
