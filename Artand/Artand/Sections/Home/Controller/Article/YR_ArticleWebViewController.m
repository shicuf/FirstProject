//
//  YR_ArticleWebViewController.m
//  Artand
//
//  Created by Dendi on 9/5/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_ArticleWebViewController.h"
#import "YR_Macro.h"
#import "AFNetworking.h"
#import "YR_ArticleDetailModel.h"
#import "YR_ArticleDetailArticleModel.h"
#import "YR_ArticleWebViewCell.h"
#import "YR_CollectionView.h"
#import "YR_ShareViewTool.h"

static NSString * const articleWebViewCell = @"articleWebViewCell";

@interface YR_ArticleWebViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) YR_CollectionView *backCollectionView;
@property (nonatomic, strong) YR_ArticleDetailModel *articleDetailModel;
@property (nonatomic, strong) NSArray *articleCountArr;
@property (nonatomic, strong) NSMutableArray *urlStrArr;

@end

@implementation YR_ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self handleData];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *rowStr = [NSString stringWithFormat:@"http://ios1.artand.cn/article/siblings?artid=%@", self.row_id];
    [manager POST:rowStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.articleCountArr = responseObject[@"list"];
        self.urlStrArr = [NSMutableArray array];
        for (int i = 0; i < self.articleCountArr.count; i++) {
            // 每篇文章的接口
            NSString *urlStr = [NSString stringWithFormat:@"http://v1.artand.cn/article/index2/%@", self.articleCountArr[i]];
            [self.urlStrArr addObject:urlStr];
        }
        NSInteger index = [self.articleCountArr indexOfObject:self.row_id];
        //        NSLog(@"%@", self.articleCountArr);
        //        NSLog(@"点击每一个cell的下标  %ld", index);
        //        NSLog(@"文章的row_id        %@", self.row_id);
        
        // 先滚动那个位置, 然后刷新
        [self.backCollectionView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0)];
        [self.backCollectionView reloadData];
        //        [self.backCollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
        [self.backCollectionView performBatchUpdates:^{
            
        } completion:^(BOOL finished) {
            // 刷新到cell上
            [_backCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:0 animated:NO];
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YRLog(@"%@", error);
    }];
}

- (void)handleWithindex:(NSInteger)index cell:(YR_ArticleWebViewCell *)cell {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *strUrl = self.urlStrArr[index];
    [manager POST:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.articleDetailModel = [YR_ArticleDetailModel modelWithDict:responseObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.articleDetailModel = self.articleDetailModel;
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YRLog(@"%@", error);
    }];
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 20);
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.backCollectionView = [[YR_CollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    self.backCollectionView.delegate = self;
    self.backCollectionView.dataSource = self;
    self.backCollectionView.pagingEnabled = YES;
    self.backCollectionView.showsHorizontalScrollIndicator = NO;
    self.backCollectionView.backgroundColor = [UIColor whiteColor];
    [self.backCollectionView registerNib:[UINib nibWithNibName:@"YR_ArticleWebViewCell" bundle:nil] forCellWithReuseIdentifier:articleWebViewCell];
    [self.view addSubview:self.backCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.articleCountArr.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x < 0) {
        scrollView.bounces = NO;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArticleWebViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:articleWebViewCell forIndexPath:indexPath];
    [self handleWithindex:indexPath.row cell:cell];
    __weak typeof(self) weakSelf = self;
    cell.popBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    cell.shareBlock = ^{
        
        YR_ShareViewTool *shareView = [[YR_ShareViewTool alloc] initWithFrame:weakSelf.view.bounds];
        [weakSelf.view addSubview:shareView];
    };
    return cell;
}


@end
