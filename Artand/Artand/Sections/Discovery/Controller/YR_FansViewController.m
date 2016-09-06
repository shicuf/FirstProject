//
//  YR_FansViewController.m
//  Artand
//
//  Created by dllo on 16/9/5.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_FansViewController.h"
#import "UIView+Frame.h"
#import "YR_Macro.h"
#import "YR_FansCollectionViewCell.h"
#import "AFNetworking.h"
#import "YR_ArtistModel.h"

static

@interface YR_FansViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *titleFlowLayout;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *contentFlowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *titleCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;

@property (nonatomic, strong) YR_ArtistModel *topModel;
@property (nonatomic, strong) YR_ArtistModel *oilModel;
@property (nonatomic, strong) YR_ArtistModel *sculptureModel;
@property (nonatomic, strong) YR_ArtistModel *deviceModel;
@property (nonatomic, strong) YR_ArtistModel *watercolorModel;
@property (nonatomic, strong) YR_ArtistModel *inkModel;
@property (nonatomic, strong) YR_ArtistModel *imageModel;
@property (nonatomic, strong) YR_ArtistModel *printModel;
@property (nonatomic, strong) YR_ArtistModel *propeneModel;
@property (nonatomic, strong) YR_ArtistModel *materialModel;
@property (nonatomic, strong) YR_ArtistModel *insetModel;
@property (nonatomic, strong) YR_ArtistModel *realisticModel;
@property (nonatomic, strong) YR_ArtistModel *digitalModel;
@property (nonatomic, strong) YR_ArtistModel *crossoverModel;


@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation YR_FansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self handleData];
    [self setupUI];
}

- (void)handleData {
    
    self.typeArray = @[@"top", @"oil", @"sculpture", @"device", @"watercolor", @"ink", @"image", @"print", @"propene", @"material", @"inset", @"realistic", @"digital", @"crossover"];
//    self.modelArray = @[self.topModel, self.oilModel, self.sculptureModel, self.deviceModel, self.watercolorModel, self.inkModel, self.imageModel, self.printModel, self.propeneModel, self.materialModel, self.insetModel, self.realisticModel, self.digitalModel, self.crossoverModel];
    
    
    for (int i = 0; i < self.typeArray.count; i++) {
//        YR_ArtistModel *__block fansModel = [YR_ArtistModel new];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *urlStr = [NSString stringWithFormat:@"http://ios1.artand.cn/discover/artist?type=%@&last_id=", self.typeArray[i]];
        [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            YR_ArtistModel *model = self.modelArray[i];
            YR_ArtistModel *fansModel = [YR_ArtistModel modelWithDict:responseObject];
            
            YR_FansCollectionViewCell *cell = (YR_FansCollectionViewCell *)[self.contentCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            cell.artistTableView.artistModel = fansModel;
            
            [self.contentCollectionView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }
    
    
}

- (void)setupUI {
    
    self.titleArray = @[@"总榜", @"油画榜", @"雕塑榜", @"装置榜", @"水彩榜", @"水墨榜", @"版画榜", @"影像榜", @"丙烯榜", @"综合材料榜", @"插画榜", @"写实艺术榜", @"数码艺术榜", @"跨界艺术家"];
    
    
    
    self.contentFlowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 108);
    self.contentFlowLayout.minimumLineSpacing = 0;
    self.contentFlowLayout.minimumInteritemSpacing = 0;
    self.contentFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.contentCollectionView.backgroundColor = [UIColor orangeColor];
    self.contentCollectionView.pagingEnabled = YES;
    self.contentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"YR_FansCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"test"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 14;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_FansCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    [cell.artistTableView reloadData];
    return cell;
}





@end
