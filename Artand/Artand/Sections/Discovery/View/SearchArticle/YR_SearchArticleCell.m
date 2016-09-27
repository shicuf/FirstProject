//
//  YR_SearchArticleCell.m
//  Artand
//
//  Created by dllo on 2016/9/22.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_SearchArticleCell.h"

@implementation YR_SearchArticleCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

    self.iconBtn.layer.cornerRadius = self.iconBtn.frame.size.width / 2;
    self.iconBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
