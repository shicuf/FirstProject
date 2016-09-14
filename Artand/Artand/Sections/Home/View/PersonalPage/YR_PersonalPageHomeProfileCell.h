//
//  YR_PersonalPageHomeProfileCell.h
//  Artand
//
//  Created by dllo on 2016/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_BaseTableViewCell.h"

@interface YR_PersonalPageHomeProfileCell : YR_BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@end
