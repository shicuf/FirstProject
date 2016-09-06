//
//  YR_ArtistTableViewCell.h
//  Artand
//
//  Created by Dendi on 9/4/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_BaseTableViewCell.h"

@class YR_ArtistWorksModel;

@interface YR_ArtistTableViewCell : YR_BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *artCollctionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *artCollectionViewFlowLayout;

@property (nonatomic, strong) NSArray<YR_ArtistWorksModel *> *worksArray;

@end
