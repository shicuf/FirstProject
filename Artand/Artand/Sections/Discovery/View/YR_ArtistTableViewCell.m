//
//  YR_ArtistTableViewCell.m
//  Artand
//
//  Created by Dendi on 9/4/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_ArtistTableViewCell.h"
#import "YR_ArtistCollectionViewCell.h"
#import "YR_ArtistWorksModel.h"
#import "YR_ArtistPicModel.h"
#import "UIImageView+WebCache.h"

@interface YR_ArtistTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation YR_ArtistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 这里面写collectionview的东西
    self.iconBtn.layer.cornerRadius = 35 / 2.0;
    self.iconBtn.layer.masksToBounds = YES;
    
    self.artCollectionViewFlowLayout.itemSize = CGSizeMake(120, 120);
    self.artCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.artCollectionViewFlowLayout.minimumLineSpacing = 10;
    self.artCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [self.artCollctionView registerNib:[UINib nibWithNibName:@"YR_ArtistCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"artReuse"];
    self.artCollctionView.backgroundColor = [UIColor whiteColor];
    self.artCollctionView.showsHorizontalScrollIndicator = NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"artReuse" forIndexPath:indexPath];
    NSString *picStr = self.worksArray[indexPath.row].pic.pid;
    NSString *fullStr = [NSString stringWithFormat:@"%@%@!app.c360.webp", @"http://work.artand.cn/", picStr];
    // http://work.artand.cn/jm/FgOqiIfoI5yInszR3mvHqQyHlENU.jpg!app.c360.webp
    [cell.artImageView sd_setImageWithURL:[NSURL URLWithString:fullStr]];
    cell.artImageView.backgroundColor = [UIColor cyanColor];
    
    return cell;
}

- (IBAction)iconBtnAction:(id)sender {
    
    
}

- (IBAction)followBtnAction:(id)sender {
    
    
}

@end
