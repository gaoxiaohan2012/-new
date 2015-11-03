//
//  MenuCollectionViewCell.m
//  WoWoZhe
//
//  Created by xiaohan on 15/10/24.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "MenuCollectionViewCell.h"

@implementation MenuCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    for (int i = 0; i<4; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*self.frame.size.width/4, 0, self.frame.size.width/4, self.frame.size.height)];
        button.backgroundColor = [UIColor clearColor];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
    }
    
    
}

- (void)btnClick:(UIButton *)btn {
    NSLog(@"首页点击了第%zd个btn",btn.tag-10);
    
}

@end
