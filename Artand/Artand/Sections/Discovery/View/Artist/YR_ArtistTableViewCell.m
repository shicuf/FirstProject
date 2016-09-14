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
#import "YR_ArtDetailViewController.h"
#import "YR_ArtistViewController.h"
#import "YR_FansViewController.h"

static NSString * const YR_ArtistCollectionViewCellReuse = @"YR_ArtistCollectionViewCellReuse";

@interface YR_ArtistTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation YR_ArtistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 这里面写collectionview的东西
    self.iconBtn.layer.cornerRadius = 35 / 2.0;
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.userInteractionEnabled = NO;
    
    self.artCollectionViewFlowLayout.itemSize = CGSizeMake(120, 120);
    self.artCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.artCollectionViewFlowLayout.minimumLineSpacing = 10;
    self.artCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [self.artCollctionView registerNib:[UINib nibWithNibName:@"YR_ArtistCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:YR_ArtistCollectionViewCellReuse];
    self.artCollctionView.backgroundColor = [UIColor whiteColor];
    self.artCollctionView.showsHorizontalScrollIndicator = NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YR_ArtistCollectionViewCellReuse forIndexPath:indexPath];
    NSString *picStr = self.worksArray[indexPath.row].pic.pid;
    NSString *fullStr = [NSString stringWithFormat:@"%@%@!app.c360.webp", @"http://work.artand.cn/", picStr];
    // http://work.artand.cn/jm/FgOqiIfoI5yInszR3mvHqQyHlENU.jpg!app.c360.webp
    [cell.artImageView sd_setImageWithURL:[NSURL URLWithString:fullStr]];
    
    
    return cell;
}
// 去掉cell重用加载上一次数据
- (void)prepareForReuse {
    
    [super prepareForReuse];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtDetailViewController *artDetailVC = [[YR_ArtDetailViewController alloc] init];
    artDetailVC.rowid = self.worksArray[indexPath.row].row_id;
    artDetailVC.imageAspectRatio = [self.worksArray[indexPath.row].pic.h floatValue] / [self.worksArray[indexPath.row].pic.w floatValue];
    [artDetailVC setHidesBottomBarWhenPushed:YES];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[1] pushViewController:artDetailVC animated:YES];
    
    
    // 这段代码多恶心 结果就一句话解决了
//    if ([self.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder isKindOfClass:[YR_ArtistViewController class]]) {
//        
//        YR_ArtistViewController *vc =  (YR_ArtistViewController *)self.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder;
//        [vc.navigationController pushViewController:artDetailVC animated:YES];
//    } else {
//        YR_FansViewController *vc =  (YR_FansViewController *)self.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder;
//        [vc.navigationController pushViewController:artDetailVC animated:YES];
//    }
    
}

- (IBAction)iconBtnAction:(id)sender {
    
    
}

- (IBAction)followBtnAction:(id)sender {
    
    
}

@end
