//
//  XHTopScrollView.m
//  WoWoZhe
//
//  Created by MS on 15/11/3.
//  Copyright © 2015年 GHX. All rights reserved.
//

#import "XHTopScrollView.h"


#define xh_BtnWith 50.0f

@implementation XHTopScrollView
{
    NSArray *_titleArr;
    NSArray *_ViewControlerArr;
}
 
- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr ViewcontrollerArr:(NSArray *)vcArr {
    self = [super init];
    if (self) {
        self.frame = frame;
        _titleArr = titleArr;
        _ViewControlerArr = vcArr;
        self.userInteractionEnabled = YES;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    for (int i = 0; i < _ViewControlerArr.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(i * xh_BtnWith, 0, xh_BtnWith, self.frame.size.height);
//        button.frame = CGRectMake(0, 0, 50, 50);
        [button setTitle:_titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor redColor];
        self.contentSize = CGSizeMake(i*xh_BtnWith, self.frame.size.height);
        [self addSubview:button];
    }
    
    
//    for ( UIView *view in self.subviews) {
//        NSLog(@"%@",view);
//    }
    
}

- (void)btnClick:(UIButton *)btn {
    
    NSLog(@"efffffffffffffffffff");
}


@end
