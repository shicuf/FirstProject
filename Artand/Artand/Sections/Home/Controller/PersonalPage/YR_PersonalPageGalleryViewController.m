//
//  YR_PersonalPageGalleryViewController.m
//  Artand
//
//  Created by dllo on 16/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageGalleryViewController.h"
#import "YR_Macro.h"
#import "YR_PersonalPageGalleryCell.h"
#import "AFNetworking.h"
#import "YR_PersonalGalleryModel.h"
#import "YR_PersonalGalleryListModel.h"
#import "UIButton+WebCache.h"
#import "YR_PersonalPageGalleryDetailViewController.h"

@interface YR_PersonalPageGalleryViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *galleryCollectionView;
@property (nonatomic, strong) YR_PersonalGalleryModel *galleryModel;

@end

@implementation YR_PersonalPageGalleryViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self handleData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // http://v1.artand.cn/user/24967/collection
    // http://album.artand.cn/6uH/Fj6NuvIT9NKEGChffiph1BT6HNjF.JPG!z300?imageView2/1/w/300/h/400%7CimageMogr2/strip/interlace/1
    // http://v1.artand.cn/collection/53750?last_id=0
    
    [self setupUI];
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 15;
    CGFloat itemWidth = (SCREEN_WIDTH - 3 * margin) / 2;
    CGFloat itemHeight = itemWidth * 4 / 3 + 60;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    self.galleryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) collectionViewLayout:layout];
    self.galleryCollectionView.backgroundColor = [UIColor whiteColor];
    [self.galleryCollectionView registerNib:[UINib nibWithNibName:@"YR_PersonalPageGalleryCell" bundle:nil] forCellWithReuseIdentifier:@"test"];
    self.galleryCollectionView.delegate = self;
    self.galleryCollectionView.dataSource = self;
    [self.view addSubview:self.galleryCollectionView];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://v1.artand.cn/user/%@/collection", self.uid];
    
    NSDictionary *header = @{@"HOST":@"v1.artand.cn",
                           @"Accept":@"*/*",
                           @"Content-Type":@"application/x-www-form-urlencoded",
                           @"Cookie":@"PHPSESSID=d126t3g2e58pmho04a4bjj7n81; language=zh-cn",
                           @"User-Agent":@"Artand/1.8.0/iPhone/9.3.3//zh-cn",
                           @"Accept-Language":@"zh-cn",
                           @"Accept-Encoding":@"gzip, deflate"};
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    for (NSString *key in header.allKeys) {
        [manager.requestSerializer setValue:[header valueForKey:key] forHTTPHeaderField:key];
    }
    
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.galleryModel = [YR_PersonalGalleryModel modelWithDict:responseObject];
        [self.galleryCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.galleryModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_PersonalPageGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    cell.nameLabel.text = self.galleryModel.list[indexPath.row].name;
    cell.descLabel.text = [NSString stringWithFormat:@"%@件作品", self.galleryModel.list[indexPath.row].num_work];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://album.artand.cn/%@!z300?imageView2/1/w/300/h/400%%7CimageMogr2/strip/interlace/1", self.galleryModel.list[indexPath.row].cover_id];
    [cell.coverBtn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_PersonalPageGalleryDetailViewController *galleryDetailVC = [[YR_PersonalPageGalleryDetailViewController alloc] init];
    galleryDetailVC.collection_id = self.galleryModel.list[indexPath.row].collection_id;
    galleryDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:galleryDetailVC animated:YES];
}



@end
