//
//  YR_EditorRecommendTableViewCell.h
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_BaseTableViewCell.h"
#import "YR_Button.h"

typedef void(^PicBtnBlock)();

@interface YR_EditorRecommendTableViewCell : YR_BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *picBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *imageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageDesLabel;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet YR_Button *likeBtn;

@property (nonatomic, copy) PicBtnBlock btnBlock;

@end
