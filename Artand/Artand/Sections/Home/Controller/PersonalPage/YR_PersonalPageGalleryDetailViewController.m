//
//  YR_PersonalPageGalleryDetailViewController.m
//  Artand
//
//  Created by Dendi on 9/13/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageGalleryDetailViewController.h"
#import "YR_Macro.h"
#import "AFNetworking.h"
#import "YR_GalleryDetailModel.h"
#import "YR_GalleryDetailCollectionModel.h"
#import "YR_GalleryDetailCateModel.h"
#import "YR_GalleryDetailListModel.h"
#import "YR_PersonalPageGalleryDetailCell.h"
#import "UIImageView+WebCache.h"
#import "YR_ArtDetailViewController.h"
#import "YR_ShareViewTool.h"

@interface YR_PersonalPageGalleryDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *galleryDetailCollectionView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) YR_GalleryDetailModel *galleryDetailModel;

@end

@implementation YR_PersonalPageGalleryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self handleData];
}

- (void)setupUI {
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:naviView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, SCREEN_WIDTH - 88, 44)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor darkGrayColor];
    [naviView addSubview:self.titleLabel];
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.frame = CGRectMake(0, 20, 44, 44);
    [popBtn setImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
    [popBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:popBtn];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(SCREEN_WIDTH - 44, 20, 44, 44);
    [moreBtn setImage:[UIImage imageNamed:@"Detailmore"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:moreBtn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 15;
    CGFloat itemWidth = SCREEN_WIDTH - margin * 2;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = 30;
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    self.galleryDetailCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    self.galleryDetailCollectionView.backgroundColor = [UIColor whiteColor];
    self.galleryDetailCollectionView.delegate = self;
    self.galleryDetailCollectionView.dataSource = self;
    [self.galleryDetailCollectionView registerNib:[UINib nibWithNibName:@"YR_PersonalPageGalleryDetailCell" bundle:nil] forCellWithReuseIdentifier:@"reuse"];
    [self.view addSubview:self.galleryDetailCollectionView];
    
    
    UIView *secSeparateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    secSeparateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [naviView addSubview:secSeparateLine];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://v1.artand.cn/collection/%@?last_id=0", self.collection_id];
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.galleryDetailModel = [YR_GalleryDetailModel modelWithDict:responseObject];
        self.titleLabel.text = self.galleryDetailModel.collection.name;
        [self.galleryDetailCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)pop:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction:(UIButton *)btn {
    
    YR_ShareViewTool *shareView = [[YR_ShareViewTool alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:shareView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.galleryDetailModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_PersonalPageGalleryDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    // http://work.artand.cn/mZR/Fm60iAwka7mSAK1ckOTeAieBwFQj.jpg!app.c540.webp
    NSString *imageURL = [NSString stringWithFormat:@"http://work.artand.cn/%@!app.c540.webp", self.galleryDetailModel.list[indexPath.row].pid];
    [cell.artImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    cell.nameLabel.text = self.galleryDetailModel.list[indexPath.row].name;
//    cell.nameLabel.font = [UIFont boldSystemFontOfSize:17];
    // 这个比上面那个字体粗
    cell.nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    // 非卖品 1 出售 2
    NSString *descStr = [NSString stringWithFormat:@"%@|%@|", self.galleryDetailModel.list[indexPath.row].quality, self.galleryDetailModel.list[indexPath.row].times];
    if ([self.galleryDetailModel.list[indexPath.row].is_sale isEqualToString:@"1"]) {
        descStr = [descStr stringByAppendingString:@"非卖品"];
    } else {
        descStr = [descStr stringByAppendingString:@"出售"];
    }
    cell.descLabel.text = descStr;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtDetailViewController *artDetailVC = [[YR_ArtDetailViewController alloc] init];
    NSString *rowid = self.galleryDetailModel.list[indexPath.row].row_id;
    artDetailVC.rowid = rowid;
    artDetailVC.imageAspectRatio = [self.galleryDetailModel.list[indexPath.row].h floatValue] / [self.galleryDetailModel.list[indexPath.row].w floatValue];
    [artDetailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:artDetailVC animated:YES];
    
}


@end
