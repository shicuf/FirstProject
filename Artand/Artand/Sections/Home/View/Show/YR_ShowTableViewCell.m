//
//  YR_ShowTableViewCell.m
//  Artand
//
//  Created by dllo on 16/8/30.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ShowTableViewCell.h"

@implementation YR_ShowTableViewCell

- (void)awakeFromNib {
    
    self.iconBtn.layer.cornerRadius = 20;
    self.iconBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)artistBtnAction:(id)sender {
    
    self.btnBlock();
}

@end
