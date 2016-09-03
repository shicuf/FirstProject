//
//  YR_ArtDetailArtistCell.m
//  Artand
//
//  Created by dllo on 16/9/2.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailArtistCell.h"

@implementation YR_ArtDetailArtistCell

- (void)awakeFromNib {
    // Initialization code
    
    self.iconBtn.layer.cornerRadius = 22;
    self.iconBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)iconAction:(id)sender {
    
    NSLog(@"点击头像");
}
- (IBAction)followAction:(id)sender {
    
    NSLog(@"关注");
}

@end
