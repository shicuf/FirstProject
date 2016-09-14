//
//  YR_PersonalPageHomeProfileCell.m
//  Artand
//
//  Created by dllo on 2016/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageHomeProfileCell.h"

@implementation YR_PersonalPageHomeProfileCell

- (void)awakeFromNib {
    // Initialization code
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor = [UIColor cyanColor];
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
