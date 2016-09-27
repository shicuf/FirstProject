//
//  YR_PersonalPageHomeArtCell.m
//  Artand
//
//  Created by dllo on 2016/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageHomeArtCell.h"

@implementation YR_PersonalPageHomeArtCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

    self.imageBtn.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
