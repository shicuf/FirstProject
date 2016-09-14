//
//  YR_ShowTableViewCell.h
//  Artand
//
//  Created by dllo on 16/8/30.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_BaseTableViewCell.h"
#import "YR_Button.h"

@interface YR_ShowTableViewCell : YR_BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *descImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet YR_Button *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *artistBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (nonatomic, copy) void (^btnBlock)();

@end
