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
#import "YR_TitleCollectionViewCell.h"
#import "YR_CollectionView.h"

static NSString * const fansTitleReuse = @"fansTitleReuse";
static NSString * const fansContentReuse = @"fansContentReuse";

@interface YR_FansViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *titleFlowLayout;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *contentFlowLayout;
@property (weak, nonatomic) IBOutlet YR_CollectionView *titleCollectionView;
@property (weak, nonatomic) IBOutlet YR_CollectionView *contentCollectionView;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation YR_FansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)handleDataWithindex:(NSInteger)index {
    
    self.typeArray = @[@"top", @"oil", @"sculpture", @"device", @"watercolor", @"ink", @"image", @"print", @"propene", @"material", @"inset", @"realistic", @"digital", @"crossover"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://ios1.artand.cn/discover/artist?type=%@&last_id=", self.typeArray[index]];
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@", responseObject);
        YR_ArtistModel *fansModel = [YR_ArtistModel modelWithDict:responseObject];
        
        YR_FansCollectionViewCell *cell = (YR_FansCollectionViewCell *)[self.contentCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        
        cell.artistTableView.artistModel = fansModel;
        
        [cell.artistTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupUI {
    
    self.titleArray = @[@"总榜", @"油画榜", @"雕塑榜", @"装置榜", @"水彩榜", @"水墨榜", @"版画榜", @"影像榜", @"丙烯榜", @"综合材料榜", @"插画榜", @"写实艺术榜", @"数码艺术榜", @"跨界艺术家"];
    
    self.titleFlowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 4, 44);
    self.titleFlowLayout.minimumLineSpacing = 0;
    self.titleFlowLayout.minimumInteritemSpacing = 0;
    self.titleFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.titleCollectionView.showsHorizontalScrollIndicator = NO;
    [self.titleCollectionView registerNib:[UINib nibWithNibName:@"YR_TitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:fansTitleReuse];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.titleCollectionView addSubview:separateLine];
    
    
    self.contentFlowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 108);
    self.contentFlowLayout.minimumLineSpacing = 0;
    self.contentFlowLayout.minimumInteritemSpacing = 0;
    self.contentFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.contentCollectionView.pagingEnabled = YES;
    self.contentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"YR_FansCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:fansContentReuse];
    
    [self.titleCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.contentCollectionView) {
        YR_FansCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:fansContentReuse forIndexPath:indexPath];
        [self handleDataWithindex:indexPath.row];
        [cell.artistTableView reloadData];
        return cell;
    } else {
        YR_TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:fansTitleReuse forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.titleLabel.textColor = [UIColor darkGrayColor];
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x < 0) {
        scrollView.bounces = NO;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    YR_TitleCollectionViewCell *cell = (YR_TitleCollectionViewCell *)[self.titleCollectionView cellForItemAtIndexPath:indexPath];
    cell.titleLabel.textColor = [UIColor blackColor];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        if (i != indexPath.row) {
            [self collectionView:self.titleCollectionView didDeselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_TitleCollectionViewCell *cell = (YR_TitleCollectionViewCell *)[self.titleCollectionView cellForItemAtIndexPath:indexPath];
    cell.titleLabel.textColor = [UIColor darkGrayColor];
}

- (IBAction)popAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}




@end
