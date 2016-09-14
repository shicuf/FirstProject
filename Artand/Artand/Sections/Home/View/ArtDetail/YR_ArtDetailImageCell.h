//
//  YR_ArtDetailImageCell.h
//  Artand
//
//  Created by dllo on 16/9/2.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_BaseTableViewCell.h"

@interface YR_ArtDetailImageCell : YR_BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *artDetailImageView;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;

@property (nonatomic, copy) void (^btnClickBlock)();

@end
