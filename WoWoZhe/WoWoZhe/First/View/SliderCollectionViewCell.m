//
//  SliderCollectionViewCell.m
//  WoWoZhe
//
//  Created by xiaohan on 15/10/24.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import "SliderCollectionViewCell.h"

#import "sliderModel.h"

@implementation SliderCollectionViewCell
{
    NSMutableArray *_dataArr;
    SDCycleScrollView *_scrollView;
    BOOL _isReload;
}

- (void)awakeFromNib {
    // Initialization code
    [self createUI];
}

- (void)createUI {
    _dataArr = [[NSMutableArray alloc]init];
    _scrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.autoScroll = YES;
    _scrollView.autoScrollTimeInterval = 5;
    _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _scrollView.delegate = self;
    
    [self.contentView addSubview:_scrollView];
}


- (void)reloadDataArr:(NSArray *)array {
    //只传入一次数据源，，，防止出现好多pagecongtroll
    if (!_isReload) {
        for (sliderModel *model in array) {
            [_dataArr addObject:model.img];
        }
        NSLog(@"-------%zd",array.count);
        [_scrollView setImageURLStringsGroup:_dataArr];
        _isReload = YES;
    }
}

#pragma mark -- delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了第%zd张",index);
    
}














@end
