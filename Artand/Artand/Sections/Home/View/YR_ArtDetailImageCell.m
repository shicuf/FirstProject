//
//  YR_ArtDetailImageCell.m
//  Artand
//
//  Created by dllo on 16/9/2.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailImageCell.h"

@implementation YR_ArtDetailImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)previewAction:(id)sender {
    
    NSLog(@"点击预览");
}

@end
