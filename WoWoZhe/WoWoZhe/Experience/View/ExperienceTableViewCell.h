//
//  ExperienceTableViewCell.h
//  WoWoZhe
//
//  Created by xiaohan on 15/11/6.
//  Copyright (c) 2015年 GHX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExperienceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainIconView;

@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mjIconView;
@property (weak, nonatomic) IBOutlet UILabel *mjLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
