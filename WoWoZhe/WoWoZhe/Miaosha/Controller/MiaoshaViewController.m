//
//  MiaoshaViewController.m
//  WoWoZhe
//
//  Created by MS on 15/10/22.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "MiaoshaViewController.h"

@interface MiaoshaViewController ()

@end

@implementation MiaoshaViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor redColor];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:@"秒杀" attributes:dic];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    label.attributedText = title;
    self.navigationItem.titleView = label;
}





















@end
