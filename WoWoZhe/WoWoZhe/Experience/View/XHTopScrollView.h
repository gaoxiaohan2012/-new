//
//  XHTopScrollView.h
//  WoWoZhe
//
//  Created by MS on 15/11/3.
//  Copyright © 2015年 GHX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHTopScrollView : UIView

//谁用它，就声明一个block等于这个block。用来传参或者执行事件。
@property (nonatomic,copy) void(^XHTopScrBlock)(UIViewController *,NSInteger);


- (instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr ViewcontrollerNameArr:(NSArray *)vcNameArr;



@end
