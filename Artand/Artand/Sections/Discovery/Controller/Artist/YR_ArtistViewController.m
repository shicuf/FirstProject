//
//  YR_ArtistViewController.m
//  Artand
//
//  Created by Dendi on 9/4/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_ArtistViewController.h"
#import "YR_ArtistTableViewCell.h"
#import "YR_ArtistTableView.h"
#import "YR_Macro.h"
#import "AFNetworking.h"
#import "YR_ArtistModel.h"
#import "YR_TitleCollectionViewCell.h"
#import "UIView+Frame.h"
#import "YR_ScrollView.h"

@interface YR_ArtistViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) YR_ScrollView *backScrollView;
@property (nonatomic, strong) YR_ArtistTableView *artistTodayTableView;
@property (nonatomic, strong) YR_ArtistTableView *artistNewTableView;
@property (weak, nonatomic) IBOutlet UIView *naviView;
@property (nonatomic, strong) UICollectionView *titleCollectionView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIView *tintView;

@end

@implementation YR_ArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self handleData];
    [self setupUI];
    [self.backScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://ios1.artand.cn/discover/artist?type=today&last_id=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.artistTodayTableView.artistModel = [YR_ArtistModel modelWithDict:responseObject];
        [self.artistTodayTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    [manager POST:@"http://ios1.artand.cn/discover/artist?type=new&last_id=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.artistNewTableView.artistModel = [YR_ArtistModel modelWithDict:responseObject];
        [self.artistNewTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    self.titleArray = @[@"今日推荐", @"最新加入"];
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 2, 44);
    layout.minimumInteritemSpacing = 0;
    self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44) collectionViewLayout:layout];
    self.titleCollectionView.delegate = self;
    self.titleCollectionView.dataSource = self;
    self.titleCollectionView.backgroundColor = [UIColor whiteColor];
    [self.titleCollectionView registerNib:[UINib nibWithNibName:@"YR_TitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"artistTitleReuse"];
    [self.naviView addSubview:self.titleCollectionView];
    
    self.tintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 2)];
    self.tintView.centerX = SCREEN_WIDTH / 4;
    self.tintView.centerY = 42.5;
    self.tintView.backgroundColor = [UIColor blackColor];
    [self.titleCollectionView addSubview:self.tintView];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.titleCollectionView addSubview:separateLine];
    
    self.backScrollView = [[YR_ScrollView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    self.backScrollView.contentSize = CGSizeMake(2 * SCREEN_WIDTH, 0);
    self.backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.pagingEnabled = YES;
    self.backScrollView.showsHorizontalScrollIndicator = NO;
    self.backScrollView.delegate = self;
    [self.view addSubview:self.backScrollView];
    
    self.artistTodayTableView = [[YR_ArtistTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) style:UITableViewStylePlain];
    self.artistTodayTableView.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:self.artistTodayTableView];
    
    self.artistNewTableView = [[YR_ArtistTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) style:UITableViewStylePlain];
    self.artistNewTableView.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:self.artistNewTableView];
}
#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.backScrollView) {
        if (scrollView.contentOffset.x <  SCREEN_WIDTH && scrollView.contentOffset.x > 0) {
            self.tintView.centerX = scrollView.contentOffset.x / 2 + SCREEN_WIDTH / 4;
        }
        if (scrollView.contentOffset.x < 0) {
            scrollView.bounces = NO;
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = self.backScrollView.contentOffset.x / SCREEN_WIDTH;
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        if (i == index) {
            [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        } else {
            [self collectionView:self.titleCollectionView didDeselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        }
    }
}
#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"artistTitleReuse" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.titleLabel.textColor = [UIColor darkGrayColor];
    [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.backScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * indexPath.row, 0) animated:YES];
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
