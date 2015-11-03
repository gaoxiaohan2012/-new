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
        [self createUI];
    }
    return self;
}

- (void)createUI {
    for (int i = 0; i < _ViewControlerArr.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(i * xh_BtnWith, 0, xh_BtnWith, self.frame.size.height);
        button.frame = CGRectMake(0, 0, 50, 50);
        [button setTitle:_titleArr[i] forState:UIControlStateNormal];
        [self addSubview:button];
    }
}




@end
