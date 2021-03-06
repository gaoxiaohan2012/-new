//
//  XHTopScrollView.m
//  WoWoZhe
//
//  Created by MS on 15/11/3.
//  Copyright © 2015年 GHX. All rights reserved.
//

#import "XHTopScrollView.h"

#define xh_BtnWith 50.0f
#define xh_BtnFont 12.0f
#define xh_topScrHeight 2.0f
#define xh_scrHeight 30.0f
#define xh_screenSize [UIScreen mainScreen].bounds.size

#define xh_topScrY xh_scrHeight - xh_topScrHeight
//#define xh_Value arc4random_uniform(256)/255.0f

@interface XHTopScrollView()<UIScrollViewDelegate>

@end
@implementation XHTopScrollView
{
    UIScrollView *_subScrollView;//view视图
    UIScrollView *_scrollView;//顶部放btn得scrollview
    NSArray *_titleArr;
    NSArray *_ViewControlerArr;
    NSMutableArray *_BtnArr;
    UIView *_topScrollView;//带动画的红条
    NSInteger _selectIndex;
    NSMutableArray *_vcArr;//将传进来的vcname装换成对象后，，存起来。
    NSArray *_urlStrArr;
}
 
- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr ViewcontrollerNameArr:(NSArray *)vcNameArr urlStrArr:(NSArray *)urlArr{
    self = [super init];
    if (self) {
        _BtnArr = [[NSMutableArray alloc]init];
        _vcArr = [[NSMutableArray alloc]init];
        self.frame = frame;
        _titleArr = titleArr;
        _ViewControlerArr = vcNameArr;
        _urlStrArr = urlArr;
        self.userInteractionEnabled = YES;
        if (_urlStrArr.count == _titleArr.count) {
            [self createUI];
            [self createSubView];
        }else {
            NSLog(@"btn数组的个数与网址数组个数不同。");
        }
    }
    
    return self;
}
#pragma mark -- 创建subview视图
- (void)createSubView {

    
    _subScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, xh_scrHeight, self.frame.size.width, xh_screenSize.height - 64 - 49 - xh_scrHeight)];
    _subScrollView.userInteractionEnabled = YES;
    _subScrollView.pagingEnabled = YES;
    _subScrollView.delegate = self;
    _subScrollView.showsHorizontalScrollIndicator = NO;
    
    int i = 0;
    for (NSString *vcName in _ViewControlerArr) {
        Class class = NSClassFromString(vcName);
        UIViewController *vc = [[class alloc]init];
        vc.view.frame = CGRectMake(i * xh_screenSize.width, 0, xh_screenSize.width, _subScrollView.frame.size.height);
        
        [_subScrollView addSubview:vc.view];
        _subScrollView.contentSize = CGSizeMake((i+1) * xh_screenSize.width, 0);
        if (i == 0) {
            _selectIndex = i;
/*
 此处为第一个视图的数据加载方法，，需要它自己去实现。在这里引进头文件.......................................................

 */
            if (_XHTopScrBlock) {
                _XHTopScrBlock(vc,_urlStrArr[0]);
            }
        }
        [_vcArr addObject:vc];//将vc加到数据里面。
    i ++;
    }
    [self addSubview:_subScrollView];
}
#pragma mark -- 创建滚动条和btn
- (void)createUI {
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, xh_scrHeight)];
    _scrollView.userInteractionEnabled = YES;
    //这一句千万他妈的不要写上 ，，，不然的话，就会自动滚动。。
//    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
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
        _scrollView.contentSize = CGSizeMake((i+1)*xh_BtnWith,0);
        [_scrollView addSubview:button];
    }
    
    [self addSubview:_scrollView];
}
#pragma mark -- btn 点击事件
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
    //点击btn时候，下面视图的滑动
    [UIView animateWithDuration:0.3 animations:^{
        _subScrollView.contentOffset = CGPointMake(_selectIndex * xh_screenSize.width, 0);
    }];
    //传值
    UIViewController *vc = _vcArr[_selectIndex];
    if (_XHTopScrBlock) {
        _XHTopScrBlock(vc,_urlStrArr[_selectIndex]);
    }
    
//    头部滚动条的位移
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = _scrollView.contentOffset;
        CGFloat lastOffset = _scrollView.contentSize.width - xh_screenSize.width;
        NSInteger oneBtnCount = xh_screenSize.width / xh_BtnWith;
        if (_selectIndex <= oneBtnCount/2) {
            return;
        }else {
            if (_scrollView.contentOffset.x >= lastOffset) {
                point.x = lastOffset;
                _scrollView.contentOffset = point;
                return;
            }
            point.x = (_selectIndex - oneBtnCount/2) * xh_BtnWith;
            _scrollView.contentOffset = point;
        }

    }];
    
    
}

#pragma mark -- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _subScrollView) {
        CGFloat offset = _subScrollView.contentOffset.x/xh_screenSize.width;
        _selectIndex = offset;
        //btn的选中状态
        for (UIButton *button  in _BtnArr) {
            if (button.tag != _selectIndex + 500) {
                button.selected = NO;
            }else {
                button.selected = YES;
            }
        }
        //滚动条的移动
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint point = _topScrollView.frame.origin;
            point.x = _selectIndex * xh_BtnWith;
            _topScrollView.frame = CGRectMake(point.x, point.y, xh_BtnWith, xh_topScrHeight);
        }];
        
        //滚动到某个subview时候，加在数据，传值
        UIViewController *vc = _vcArr[_selectIndex];
        if (_XHTopScrBlock) {
            _XHTopScrBlock(vc,_urlStrArr[_selectIndex]);
        }
        
        //头部滚动条的位移
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint point = _scrollView.contentOffset;
            //一个屏幕的btn总数
            NSInteger oneBtnCount = xh_screenSize.width / xh_BtnWith;
            //所有的btn总数
            NSInteger allBtnCount = _scrollView.contentSize.width / xh_BtnWith;
            //判断是否选中的btn超过了屏幕一半。
            if (_selectIndex >= oneBtnCount/2) {
                //如果就剩最后几个btn了，，直接跳出，不再位移了。
                if (allBtnCount - _selectIndex <= oneBtnCount/2) {
                    return;
                }
                point.x = xh_BtnWith * (_selectIndex - oneBtnCount/2);
                _scrollView.contentOffset = point;
            }else {
                point.x = 0;
                _scrollView.contentOffset  = point;
            }
        }];
        
    }
}

@end
