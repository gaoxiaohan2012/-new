//
//  XHTopScrollView.h
//  WoWoZhe
//
//  Created by MS on 15/11/3.
//  Copyright © 2015年 GHX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHTopScrollView : UIView

//谁用它，就声明一个block等于这个block。用来传参或者执行事件。传进来一个控制器，和一个请求数据的网址
@property (nonatomic,copy) void(^XHTopScrBlock)(UIViewController *,NSString *);



//初始化这个view视图。。传进来一个btn的title数组，和一个控制器的类名字符串数组。
- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr ViewcontrollerNameArr:(NSArray *)vcNameArr urlStrArr:(NSArray *)urlArr;


//仅限不是tableVIew或者是collectionView的页面
//如果是第一个控制器的view还要传进来一个方法，，用来刷新自己的view。。需要一个urlStr
//什么样的view就用什么方法。。



@end
