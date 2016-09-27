//
//  YR_ArtDetailRewardCell.m
//  Artand
//
//  Created by dllo on 16/9/2.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailRewardCell.h"
#import "YR_Macro.h"

@interface YR_ArtDetailRewardCell ()

@property (weak, nonatomic) IBOutlet UIButton *rewardBtn;


@end

@implementation YR_ArtDetailRewardCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

    self.rewardBtn.layer.cornerRadius = 5;
    self.rewardBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)rewardAction:(id)sender {
    
    YRLog(@"打赏");
}

@end
