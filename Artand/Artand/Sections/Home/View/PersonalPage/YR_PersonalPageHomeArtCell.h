//
//  YR_PersonalPageHomeArtCell.h
//  Artand
//
//  Created by dllo on 2016/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YR_PersonalPageHomeArtCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *priceView;

@end
