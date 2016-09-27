//
//  YR_EditorRecommendTableViewCell.m
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_EditorRecommendTableViewCell.h"

@implementation YR_EditorRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconBtn.layer.cornerRadius = self.iconBtn.frame.size.width / 2;
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickImageAction:(id)sender {
    
    if (self.btnBlock) {
        self.btnBlock();
    }
}
- (IBAction)clickIconAction:(id)sender {
}
- (IBAction)clickArtistNameAction:(id)sender {
}
- (IBAction)clickLikeAction:(id)sender {
}

@end
