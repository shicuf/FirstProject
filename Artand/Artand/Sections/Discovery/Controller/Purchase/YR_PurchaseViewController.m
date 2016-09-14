//
//  YR_PurchaseViewController.m
//  Artand
//
//  Created by Dendi on 9/4/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_PurchaseViewController.h"
#import "YR_Macro.h"
#import "YR_PurchaseCell.h"
#import "AFNetworking.h"
#import "YR_PurchaseModel.h"
#import "YR_PurchaseListModel.h"
#import "YR_PurchasePicModel.h"
#import "UIButton+WebCache.h"
#import "YR_ArtDetailViewController.h"

static NSString * const purchaseCellReuse = @"purchaseCellReuse";

@interface YR_PurchaseViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) YR_PurchaseModel *purchaseModel;
@property (weak, nonatomic) IBOutlet UICollectionView *artCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *artCollectionViewFlowLayout;

@end

@implementation YR_PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self handleData];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 1) / 2;
    self.artCollectionViewFlowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    self.artCollectionViewFlowLayout.minimumLineSpacing = 1;
    self.artCollectionViewFlowLayout.minimumInteritemSpacing = 1;
    
    [self.artCollectionView registerNib:[UINib nibWithNibName:@"YR_PurchaseCell" bundle:nil] forCellWithReuseIdentifier:purchaseCellReuse];
}

- (void)handleData {
    
    // http://work.artand.cn/GLC/FiKGf3GvYbLL99s1Qk7w5Nx6dbg7.jpeg!app.c360.webp
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://ios1.artand.cn/sale/search?" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.purchaseModel = [YR_PurchaseModel modelWithDict:responseObject];
        [self.artCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.purchaseModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_PurchaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:purchaseCellReuse forIndexPath:indexPath];
    NSString *imageURLStr = [NSString stringWithFormat:@"http://work.artand.cn/%@!app.c360.webp", self.purchaseModel.list[indexPath.row].pic.pid];
    [cell.imageBtn sd_setImageWithURL:[NSURL URLWithString:imageURLStr] forState:UIControlStateNormal];
    NSString *priceStr = self.purchaseModel.list[indexPath.row].price;
    NSString *newPriceStr = [priceStr substringToIndex:[priceStr length] - 3];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", newPriceStr];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtDetailViewController *artDetailVC = [[YR_ArtDetailViewController alloc] init];
    artDetailVC.rowid = self.purchaseModel.list[indexPath.row].row_id;
    artDetailVC.imageAspectRatio = [self.purchaseModel.list[indexPath.row].pic.h floatValue] / [self.purchaseModel.list[indexPath.row].pic.w floatValue];
    [artDetailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:artDetailVC animated:YES];
}
- (IBAction)popAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
