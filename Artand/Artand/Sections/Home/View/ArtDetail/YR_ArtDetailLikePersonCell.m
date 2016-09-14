//
//  YR_ArtDetailLikePersonCell.m
//  Artand
//
//  Created by dllo on 2016/9/13.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailLikePersonCell.h"
#import "YR_Macro.h"

@implementation YR_ArtDetailLikePersonCell

- (void)awakeFromNib {
    // Initialization code
    self.iconBtn.layer.cornerRadius = 16;
    self.iconBtn.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)followBtnAction:(id)sender {
    
    YRLog(@"关注");
}

@end
