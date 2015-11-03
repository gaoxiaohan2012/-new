//
//  SliderCollectionViewCell.h
//  WoWoZhe
//
//  Created by xiaohan on 15/10/24.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "SDCollectionViewCell.h"

@interface SliderCollectionViewCell : UICollectionViewCell<SDCycleScrollViewDelegate>



- (void)reloadDataArr:(NSArray *)array;


@end
