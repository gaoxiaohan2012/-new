//
//  XHTopScrollView.m
//  WoWoZhe
//
//  Created by MS on 15/11/3.
//  Copyright © 2015年 GHX. All rights reserved.
//

#import "XHTopScrollView.h"


#define xh_BtnWith 40.0f
#define xh_BtnFont 13.0f
#define xh_topScrHeight 2.0f
#define xh_scrHeight 40.0f

#define xh_topScrY xh_scrHeight - xh_topScrHeight

@implementation XHTopScrollView
{
    UIScrollView *_scrollView;
    NSArray *_titleArr;
    NSArray *_ViewControlerArr;
    NSMutableArray *_BtnArr;
    UIView *_topScrollView;
    CGFloat _selectIndex;
}
 
- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr ViewcontrollerArr:(NSArray *)vcArr {
    self = [super init];
    if (self) {
        self.frame = frame;
        _titleArr = titleArr;
        _ViewControlerArr = vcArr;
        _BtnArr = [[NSMutableArray alloc]init];
        self.userInteractionEnabled = YES;
        [self createUI];
        [self createSubView];
    }
    return self;
}
- (void)createSubView {
    for (UIViewController *vc in _ViewControlerArr) {
        
    }
    
    
}

- (void)createUI {
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, xh_scrHeight)];
    _scrollView.userInteractionEnabled = YES;
    
    
    _topScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, xh_topScrY, xh_BtnWith, xh_topScrHeight)];
    _topScrollView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_topScrollView];
    
    for (int i = 0; i < _ViewControlerArr.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(i * xh_BtnWith, 0, xh_BtnWith, xh_scrHeight);
        [button setTitle:_titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:xh_BtnFont];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 500 + i;
        
        [_BtnArr addObject:button];
        _scrollView.contentSize = CGSizeMake(i*xh_BtnWith, self.frame.size.height);
        [_scrollView addSubview:button];
    }
    
    [self addSubview:_scrollView];
}

- (void)btnClick:(UIButton *)btn {
    for (UIButton *button in _BtnArr) {
        if (button != btn) {
            button.selected = NO;
        }
    }
    btn.selected = YES;
    _selectIndex = btn.tag - 500;
    [UIView animateWithDuration:0.3 animations:^{
        _topScrollView.frame = CGRectMake(_selectIndex * xh_BtnWith, xh_topScrY, xh_BtnWith, xh_topScrHeight);
    }];
    
}


@end
