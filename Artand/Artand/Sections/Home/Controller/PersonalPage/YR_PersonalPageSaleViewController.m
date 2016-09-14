//
//  YR_PersonalPageSaleViewController.m
//  Artand
//
//  Created by dllo on 16/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageSaleViewController.h"
#import "YR_Macro.h"
#import "AFNetworking.h"
#import "YR_PurchaseCell.h"
#import "UIButton+WebCache.h"
#import "YR_ArtDetailViewController.h"
#import "YR_PersonalSaleModel.h"
#import "YR_PersonalSaleListModel.h"

static NSString * const saleCellReuse = @"saleCellReuse";

@interface YR_PersonalPageSaleViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *saleCollectionView;
@property (nonatomic, strong) YR_PersonalSaleModel *saleModel;

@end

@implementation YR_PersonalPageSaleViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self handleData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // http://v1.artand.cn/user/24967/sale
    [self setupEmptyUI];
    [self setupUI];
    
}

- (void)setupUI {
    
    CGFloat itemWidth = (SCREEN_WIDTH - 1) / 2;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    self.saleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) collectionViewLayout:layout];
    self.saleCollectionView.delegate = self;
    self.saleCollectionView.dataSource = self;
    [self.saleCollectionView registerNib:[UINib nibWithNibName:@"YR_PurchaseCell" bundle:nil] forCellWithReuseIdentifier:saleCellReuse];
    self.saleCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.saleCollectionView];
    
}

- (void)setupEmptyUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_onsale"]];
    imageView.frame = CGRectMake(0, 0, 100, 100);
    imageView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT * 0.2);
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, SCREEN_WIDTH, 20)];
    label.text = @"这家伙很懒, 还没有出售中的作品";
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://v1.artand.cn/user/%@/sale", self.uid];
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.saleModel = [YR_PersonalSaleModel modelWithDict:responseObject];
        [self.saleCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.saleModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_PurchaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:saleCellReuse forIndexPath:indexPath];
    NSString *imageURLStr = [NSString stringWithFormat:@"http://work.artand.cn/%@!app.c360.webp", self.saleModel.list[indexPath.row].pid];
    [cell.imageBtn sd_setImageWithURL:[NSURL URLWithString:imageURLStr] forState:UIControlStateNormal];
    NSString *priceStr = self.saleModel.list[indexPath.row].price;
    NSString *newPriceStr = [priceStr substringToIndex:[priceStr length] - 3];
    if ([newPriceStr isEqualToString:@"0"]) {
        cell.priceLabel.text = @"议价出售";
    } else {
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", newPriceStr];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtDetailViewController *artDetailVC = [[YR_ArtDetailViewController alloc] init];
    artDetailVC.rowid = self.saleModel.list[indexPath.row].row_id;
    artDetailVC.imageAspectRatio = [self.saleModel.list[indexPath.row].h floatValue] / [self.saleModel.list[indexPath.row].w floatValue];
    [artDetailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:artDetailVC animated:YES];
}


@end
