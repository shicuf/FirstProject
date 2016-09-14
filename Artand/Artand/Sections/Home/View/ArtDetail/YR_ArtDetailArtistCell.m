//
//  YR_ArtDetailArtistCell.m
//  Artand
//
//  Created by dllo on 16/9/2.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailArtistCell.h"
#import "YR_Macro.h"

@implementation YR_ArtDetailArtistCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.iconBtn.layer.cornerRadius = 22;
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)followAction:(id)sender {
    
    YRLog(@"关注");
}

@end
