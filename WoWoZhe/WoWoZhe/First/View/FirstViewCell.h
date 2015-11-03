//
//  FirstViewCell.h
//  WoWoZhe
//
//  Created by MS on 15/10/23.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end
