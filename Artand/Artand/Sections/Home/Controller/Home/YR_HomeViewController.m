//
//  YR_HomeViewController.m
//  Artand
//
//  Created by dllo on 16/8/27.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_HomeViewController.h"
#import "YR_Macro.h"
#import "UIView+Frame.h"
#import "AFNetworking.h"
#import "YR_CycleModel.h"
#import "YR_CycleImage.h"
#import "YR_Ads.h"
#import "UIImageView+WebCache.h"
#import "YR_EditorRecommendTableViewCell.h"
#import "YR_EditorRecommendModel.h"
#import "UIButton+WebCache.h"
#import "YR_EditorRecommendListModel.h"
#import "YR_EditorRecommendPicModel.h"
#import "YR_EditorRecommendUserModel.h"
#import "YR_ArticleCollectionViewCell.h"
#import "UIImage+WebP.h"
#import "YR_NewArtsModel.h"
#import "YR_NewArtsListModel.h"
#import "YR_NewArtsPicModel.h"
#import "YR_ShowTableViewCell.h"
#import "YR_ShowModel.h"
#import "YR_ShowListModel.h"
#import "YR_ShowUserModel.h"
#import "Masonry.h"
#import "YR_TitleCollectionViewCell.h"
#import "YR_BaseNavigationController.h"
#import "YR_CycleImageDetailViewController.h"
#import "YR_LikeListViewController.h"
#import "YR_ArtDetailViewController.h"
#import "YR_ArticleWebViewController.h"
#import "YR_CollectionView.h"
#import "YR_ScrollView.h"
#import "YR_PersonalPageViewController.h"
#import "MJRefresh.h"
#import "NSString+YR_TimeInterval.h"
#import "YR_RefreshGiHeaderTool.h"
#import "YR_SearchViewController.h"

static NSString * const recommendTableViewCellReuse = @"recommendTableViewReuse";
static NSString * const articleCollectionViewCellReuse = @"articleCollectionViewCellReuse";
static NSString * const showTableViewCellReuse = @"showTableViewCellReuse";

@interface YR_HomeViewController () <UITableViewDelegate, UITableViewDataSource, /*YR_CycleImagesDelegate, YR_CycleImageDataSource,*/ UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) YR_ScrollView *backScrollView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) UIView *homeTableHeaderView;
@property (nonatomic, strong) UIView *cycleBackView;
@property (nonatomic, strong) UIView *likeListView;
@property (nonatomic, strong) UIView *editorRecommendView;
@property (nonatomic, strong) YR_CycleModel *cycleModel;
@property (nonatomic, strong) YR_CycleImage *cycleImage;
@property (nonatomic, strong) NSMutableArray *picArr;
@property (nonatomic, strong) YR_EditorRecommendModel *editorRecommendModel;
@property (nonatomic, strong) YR_EditorRecommendTableViewCell *cell;
@property (nonatomic, strong) YR_NewArtsModel *a_newArtsModel;
@property (nonatomic, strong) UICollectionView *articleCollectionView;
@property (nonatomic, strong) UITableView *showTableView;
@property (nonatomic, strong) YR_ShowModel *showModel;
@property (nonatomic, strong) UICollectionView *titleCollectionView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIView *tintView;

@property (nonatomic, strong) NSMutableArray<YR_EditorRecommendListModel *> *editorRecommendListModelArr;
@property (nonatomic, strong) NSMutableArray<YR_NewArtsListModel *> *a_newArtsListModelArr;
@property (nonatomic, strong) NSMutableArray<YR_ShowListModel *> *showListModelArr;

@property (nonatomic, strong) YR_RefreshGiHeaderTool *homeTableViewHeaderTool;
@property (nonatomic, strong) YR_RefreshGiHeaderTool *showTableViewHeaderTool;
@property (nonatomic, strong) YR_RefreshGiHeaderTool *articleCollectionViewHeaderTool;

@end

@implementation YR_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArr = @[@"推荐", @"新作", @"展览"];

    [self handleData];
    [self setupUI];
}
#pragma mark - 处理数据
- (void)handleData {
    
    self.manager = [AFHTTPSessionManager manager];
    /**
     *  轮播图请求
     *
     *  @param task           nil
     *  @param responseObject 返回轮播图片数据
     *
     *  @return
     */
//    [self.manager GET:@"http://ios1.artand.cn/discover/home/rank" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        self.cycleModel = [YR_CycleModel modelWithDict:responseObject];
//
//        NSMutableArray *arr = [NSMutableArray array];
//        for (int i = 0 ; i < self.cycleModel.ads.count; i++) {
//            NSString *pic = self.cycleModel.ads[i].pic;
//            [arr addObject:pic];
//        }
//        _picArr = arr;
//        NSString *firstImage = [_picArr firstObject];
//        NSString *lastImage = [_picArr lastObject];
//        [_picArr insertObject:lastImage atIndex:0];
//        [_picArr addObject:firstImage];
//        self.cycleImage.array = _picArr;
//        [self.homeTableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    /**
     *  编辑推荐请求
     *
     *  @param task           nil
     *  @param responseObject homeTableView上的数据
     *
     *  @return
     */
    [self.manager POST:@"http://ios1.artand.cn/discover/work/hot" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        self.editorRecommendModel = [YR_EditorRecommendModel modelWithDict:dic];
        for (YR_EditorRecommendListModel *list in self.editorRecommendModel.list) {
            [self.editorRecommendListModelArr addObject:list];
        }
        [self.homeTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    /**
     *  新作界面请求
     *
     *  @param task           nil
     *  @param responseObject 新作图片数据
     *
     *  @return
     */
    [self.manager POST:@"http://ios1.artand.cn/discover/work/new?last_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.a_newArtsModel = [YR_NewArtsModel modelWithDict:responseObject];
        for (YR_NewArtsListModel *list in self.a_newArtsModel.list) {
            [self.a_newArtsListModelArr addObject:list];
        }
        
        [self.articleCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    /**
     *  展览界面请求而
     *
     *  @param task           nil
     *  @param responseObject showTableView上的数据
     *
     *  @return
     */
    [self.manager POST:@"http://ios1.artand.cn/discover/news?type=exhibit&last_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.showModel = [YR_ShowModel modelWithDict:responseObject];
        for (YR_ShowListModel *list in self.showModel.list) {
            [self.showListModelArr addObject:list];
        }
        [self.showTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - 设置UI
- (void)setupUI {
    
    self.picArr = [NSMutableArray array];
    [self setupTitleView];
    [self setupBackScrollView];
    [self setupHomeTableView];
//    [self setupCycleImageView];
    [self setupArticleCollectionView];
    [self setupShowTableView];
}
#pragma mark - 设置导航条视图
- (void)setupTitleView {
    
    
    self.navigationController.delegate = self;
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:self.titleView];
    self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 88, 24)];
    self.titleImageView.centerX = self.titleView.centerX;
    self.titleImageView.image = [UIImage imageNamed:@"icon_logo"];
    [self.titleView addSubview:self.titleImageView];
    
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.frame = CGRectMake(SCREEN_WIDTH - 44, 20, 44, 44);
    [postBtn setImage:[UIImage imageNamed:@"fabuicon0"] forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(postMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:postBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 20, 44, 44);
    [searchBtn setImage:[UIImage imageNamed:@"icon_find"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(enterSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:searchBtn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = SCREEN_WIDTH / 3;
    CGFloat itemHeight = 30;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 30) collectionViewLayout:layout];
    [self.titleCollectionView registerNib:[UINib nibWithNibName:@"YR_TitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"reuse"];
    self.titleCollectionView.delegate = self;
    self.titleCollectionView.dataSource = self;
    self.titleCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleCollectionView];
    [self.titleCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    
    CGFloat width = 30;
    CGFloat height = 2;
    self.tintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.tintView.centerX = SCREEN_WIDTH / 6;
    self.tintView.centerY = self.titleCollectionView.height - 2.5;
    self.tintView.backgroundColor = [UIColor blackColor];
    [self.titleCollectionView addSubview:self.tintView];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    separateLine.centerX = SCREEN_WIDTH / 2;
    separateLine.centerY = self.titleCollectionView.height - 0.25;
    [self.titleCollectionView addSubview:separateLine];
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    statusView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statusView];
}

- (void)postMessage:(UIButton *)btn {
    
    
}

- (void)enterSearch:(UIButton *)btn {
    
    YR_SearchViewController *searchVC = [YR_SearchViewController new];
    CATransition *transition=[CATransition animation];
    transition.type= kCATransitionFade;
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
}

#pragma mark - 设置背景滚动视图 scrollView
- (void)setupBackScrollView {
    
    CGFloat naviHeight = 64;
    CGFloat titleHeight = 30;
    CGFloat tabBarHeight = 49;
    self.backScrollView = [[YR_ScrollView alloc] initWithFrame:CGRectMake(0, naviHeight + titleHeight, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight - titleHeight - tabBarHeight)];
    [self.view addSubview:self.backScrollView];
    self.backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.delegate = self;
    self.backScrollView.showsHorizontalScrollIndicator = NO;
    self.backScrollView.pagingEnabled = YES;
    self.backScrollView.contentSize = CGSizeMake(3 * SCREEN_WIDTH, 0);
}
#pragma mark - 设置轮播图
//- (void)setupCycleImageView {
//    
//    self.cycleImage = [[YR_CycleImage alloc] initWithFrame:self.cycleBackView.frame];
//    [self.cycleBackView addSubview:self.cycleImage];
//    self.cycleImage.delegate = self;
//    self.cycleImage.dataSource = self;
//}
#pragma mark - 轮播图回调赋值
//- (void)handleDataWithObject:(id)objc cell:(__kindof UICollectionViewCell *)cell {
//    
//    YRCycleImagesCell *imageCell = cell;
//    [imageCell.cycleImageView sd_setImageWithURL:[NSURL URLWithString:objc]];
//}
#pragma mark - 轮播图监听点击
//- (void)cycleImagesActionWithIndexPath:(NSIndexPath *)indexPath {
//    
//    YR_CycleImageDetailViewController *dVC = [[YR_CycleImageDetailViewController alloc] init];
//    [dVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:dVC animated:YES];
//    NSURL *url = [NSURL URLWithString:self.cycleModel.ads[indexPath.row - 1].url];
//    dVC.detailUrl = url;
//    dVC.titleStr = self.cycleModel.ads[indexPath.row - 1].title;
//}
#pragma mark - 设置tableView
- (void)setupHomeTableView {
    
    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.backScrollView.height) style:UITableViewStylePlain];
    [self.backScrollView addSubview:self.homeTableView];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    [self.homeTableView registerNib:[UINib nibWithNibName:@"YR_EditorRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:recommendTableViewCellReuse];
    
    self.editorRecommendListModelArr = [NSMutableArray array];
    
    
    self.homeTableViewHeaderTool = [[YR_RefreshGiHeaderTool alloc] initWithScrollView:self.homeTableView requestBlock:^{
        
        [self.manager POST:@"http://ios1.artand.cn/discover/work/hot" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = responseObject;
            self.editorRecommendModel = [YR_EditorRecommendModel modelWithDict:dic];
            [self.editorRecommendListModelArr removeAllObjects];
            for (YR_EditorRecommendListModel *list in self.editorRecommendModel.list) {
                [self.editorRecommendListModelArr addObject:list];
            }
            [self.homeTableView reloadData];
            [self.homeTableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
    
    MJRefreshAutoFooter *homeTableViewFooter = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self.manager POST:@"http://ios1.artand.cn/discover/work/hot" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = responseObject;
            self.editorRecommendModel = [YR_EditorRecommendModel modelWithDict:dic];
            for (YR_EditorRecommendListModel *list in self.editorRecommendModel.list) {
                [self.editorRecommendListModelArr addObject:list];
            }

            [self.homeTableView reloadData];
            [self.homeTableView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
    
    self.homeTableView.mj_footer = homeTableViewFooter;
    
//    self.cycleBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 2)];
    
    self.likeListView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 94 - 44) / 3)];
    UIView *likeListTintView = [[UIView alloc] initWithFrame:CGRectMake(10, 14, 2, 12)];
    likeListTintView.backgroundColor = [UIColor blackColor];
    [self.likeListView addSubview:likeListTintView];
    UILabel *likeListLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 40)];
    likeListLabel.text = @"点赞榜";
    likeListLabel.textColor = [UIColor darkGrayColor];
    likeListLabel.font = [UIFont systemFontOfSize:14];
    [self.likeListView addSubview:likeListLabel];
    
    self.editorRecommendView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.likeListView.frame), SCREEN_WIDTH, 40)];
    UIView *editorRecommendTintView = [[UIView alloc] initWithFrame:CGRectMake(10, 14, 2, 12)];
    editorRecommendTintView.backgroundColor = [UIColor blackColor];
    [self.editorRecommendView addSubview:editorRecommendTintView];
    UILabel *editorRecommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 40)];
    editorRecommendLabel.text = @"编辑推荐";
    editorRecommendLabel.textColor = [UIColor darkGrayColor];
    editorRecommendLabel.font = [UIFont systemFontOfSize:14];
    [self.editorRecommendView addSubview:editorRecommendLabel];
    
    CGFloat btnMargin = 10;
    CGFloat btnWidth = (SCREEN_WIDTH - 4 * btnMargin) / 3;
    NSArray *btnImageArr = @[@"ribang", @"zhoubang", @"yuebang"];
    for (int i = 0; i < 3; i++) {
        UIButton *listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        listBtn.frame = CGRectMake(btnMargin + i * (btnWidth + btnMargin), 40, btnWidth, btnWidth);
        [listBtn setImage:[UIImage imageNamed:btnImageArr[i]] forState:UIControlStateNormal];
        listBtn.tag = 10010 + i;
        [listBtn addTarget:self action:@selector(pushDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.likeListView addSubview:listBtn];
    }
    
    self.homeTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.likeListView.height + self.editorRecommendView.height)];
    [self.homeTableHeaderView addSubview:self.cycleBackView];
    [self.homeTableHeaderView addSubview:self.likeListView];
    [self.homeTableHeaderView addSubview:self.editorRecommendView];
    self.homeTableView.tableHeaderView = self.homeTableHeaderView;
}
#pragma mark - 点赞榜点击方法
- (void)pushDetail:(UIButton *)btn {
    
    YR_LikeListViewController *likeListVc = [[YR_LikeListViewController alloc] init];
    [likeListVc setHidesBottomBarWhenPushed:YES];
    if (btn.tag == 10010) {
        likeListVc.index = 0;
    } else if (btn.tag == 10011) {
        likeListVc.index = 1;
    } else if (btn.tag == 10012) {
        likeListVc.index = 2;
    }
    [self.navigationController pushViewController:likeListVc animated:YES];
}

#pragma mark - 设置展览界面
- (void)setupShowTableView {
    
    self.showTableView = [[UITableView alloc] initWithFrame:CGRectMake(2 * SCREEN_WIDTH, 0, SCREEN_WIDTH, self.backScrollView.height) style:UITableViewStylePlain];
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    self.showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.showTableView registerNib:[UINib nibWithNibName:@"YR_ShowTableViewCell" bundle:nil] forCellReuseIdentifier:showTableViewCellReuse];
    [self.backScrollView addSubview:self.showTableView];
    
    self.showListModelArr = [NSMutableArray array];
    
    self.showTableViewHeaderTool = [[YR_RefreshGiHeaderTool alloc] initWithScrollView:self.showTableView requestBlock:^{
        
        [self.manager POST:@"http://ios1.artand.cn/discover/news?type=exhibit&last_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.showModel = [YR_ShowModel modelWithDict:responseObject];
            [self.showListModelArr removeAllObjects];
            for (YR_ShowListModel *list in self.showModel.list) {
                [self.showListModelArr addObject:list];
            }
            [self.showTableView reloadData];
            [self.showTableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
    
    self.showTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSString *urlStr = [NSString stringWithFormat:@"http://ios1.artand.cn/discover/news?type=exhibit&last_id=%@", self.showModel.last_id];
        [self.manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.showModel = [YR_ShowModel modelWithDict:responseObject];
            for (YR_ShowListModel *list in self.showModel.list) {
                [self.showListModelArr addObject:list];
            }
            [self.showTableView reloadData];
            [self.showTableView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.homeTableView) {
        return self.editorRecommendListModelArr.count;
    } else {
        return self.showListModelArr.count;
    }
}
#pragma mark - tableView数据

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.homeTableView) {
        YR_EditorRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTableViewCellReuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *picStr = self.editorRecommendListModelArr[indexPath.row].pic.pid;
        NSString *fullStr = [NSString stringWithFormat:@"%@%@!app.c540.webp", @"http://work.artand.cn/", picStr];
        // http://work.artand.cn/6az/lsz_-PzBcWBRF8Bpvudome4WLG9Y.jpg!app.c540.webp
        NSURL *picUrl = [NSURL URLWithString:fullStr];
        [cell.picBtn sd_setImageWithURL:picUrl forState:UIControlStateNormal];
        
        NSString *uidStr = self.editorRecommendListModelArr[indexPath.row].user.uid;
        NSString *versionStr = self.editorRecommendListModelArr[indexPath.row].user.version;
        NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
        [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
        
        cell.imageNameLabel.text = self.editorRecommendListModelArr[indexPath.row].name;
        cell.artistNameLabel.text = self.editorRecommendListModelArr[indexPath.row].user.uname;
        cell.locationLabel.text = self.editorRecommendListModelArr[indexPath.row].user.city;
        
        NSString *likeStr = [NSString stringWithFormat:@"%@", self.editorRecommendListModelArr[indexPath.row].num_liked];
        [cell.likeBtn setTitle:likeStr forState:UIControlStateNormal];
        NSString *priceStr = self.editorRecommendListModelArr[indexPath.row].price;
        float price = [priceStr floatValue];
        if ([priceStr isEqualToString:@"0.00"]) {
            cell.priceView.hidden = YES;
        } else {
            cell.priceView.hidden = NO;
            if (price > 1000.0) {
                NSString *newPriceStr = [NSString stringWithFormat:@"¥%.2fK", price / 1000.0];
                cell.priceLabel.text = newPriceStr;
            } else {
                cell.priceLabel.text = priceStr;
            }
        }
        // 获取到更新的时间戳
        NSString *timeStr = self.editorRecommendListModelArr[indexPath.row].mtime;
        NSString *newStr = [timeStr updateTimeForTimeIntervalString:timeStr];
        cell.timeLabel.text = newStr;
        
        NSString *categoryStr = self.editorRecommendListModelArr[indexPath.row].category;
        NSString *sizeLabelStr = self.editorRecommendListModelArr[indexPath.row].size_label;
        NSString *timesStr = self.editorRecommendListModelArr[indexPath.row].times;
        NSString *descStr = [[categoryStr stringByAppendingPathComponent:sizeLabelStr] stringByAppendingPathComponent:timesStr];
        if ([priceStr isEqualToString:@"0.00"]) {
            cell.imageDesLabel.text = [descStr stringByAppendingPathComponent:@"非卖品"];
        } else {
            cell.imageDesLabel.text = descStr;
        }
        // cell的block属性 添加点击方法
        cell.btnBlock = ^{
            
            YR_ArtDetailViewController *artDetailVC = [[YR_ArtDetailViewController alloc] init];
            
            // 拼接链接的字符串
            NSString *rowid = self.editorRecommendListModelArr[indexPath.row].row_id;
            artDetailVC.rowid = rowid;
            
            // 点击图片的高宽比
            artDetailVC.imageAspectRatio = [self.editorRecommendListModelArr[indexPath.row].pic.h floatValue] / [self.editorRecommendListModelArr[indexPath.row].pic.w floatValue];
            [artDetailVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:artDetailVC animated:YES];
        };
        return cell;
    } else {
        YR_ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:showTableViewCellReuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.descLabel.text = self.showListModelArr[indexPath.row].desc;
        cell.titleLabel.text = self.showListModelArr[indexPath.row].title;
        cell.nameLabel.text = self.showListModelArr[indexPath.row].user.uname;
        cell.locationLabel.text = self.showListModelArr[indexPath.row].user.city;
        NSString *likeStr = [NSString stringWithFormat:@"%@", self.showListModelArr[indexPath.row].num_liked];
        [cell.likeBtn setTitle:likeStr forState:UIControlStateNormal];
        
        NSString *uidStr = self.showListModelArr[indexPath.row].user.uid;
        NSString *versionStr = self.showListModelArr[indexPath.row].user.version;
        NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
        [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
        NSString *coverStr = self.showListModelArr[indexPath.row].pid;
        NSString *fullStr = [NSString stringWithFormat:@"http://news.artand.cn/%@?imageView2/1/w/600/h/180%%7CimageMogr2/strip/interlace/1", coverStr];
        
        // 获取到更新的时间戳
        NSString *timeStr = self.showListModelArr[indexPath.row].mtime;
        NSString *newStr = [timeStr updateTimeForTimeIntervalString:timeStr];
        cell.timeLabel.text = newStr;
        
        [cell.descImageView setContentMode:UIViewContentModeScaleAspectFill];
        [cell.descImageView sd_setImageWithURL:[NSURL URLWithString:fullStr]];
        cell.btnBlock = ^{
            
            YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
            personalPageVC.uid = self.showListModelArr[indexPath.row].uid;
            personalPageVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personalPageVC animated:YES];
        };
        return  cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 进入艺术家个人主页
    if (tableView == self.homeTableView) {
        // 点击cell请求 http://v1.artand.cn/user/24967 主页请求
        YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
        personalPageVC.uid = self.editorRecommendListModelArr[indexPath.row].uid;
        personalPageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personalPageVC animated:YES];
    }
    
    // 点击展览页的cell
    if (tableView == self.showTableView) {
        YR_ArticleWebViewController *articleWebViewVC = [[YR_ArticleWebViewController alloc] init];
        articleWebViewVC.row_id = self.showListModelArr[indexPath.row].row_id;
        articleWebViewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:articleWebViewVC animated:YES];
    }
}
#pragma mark - 监听滑动便宜title视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.backScrollView) {
        if (scrollView.contentOffset.x < 2 * SCREEN_WIDTH && scrollView.contentOffset.x > 0) {
            
            self.tintView.centerX = self.backScrollView.contentOffset.x / 3 + SCREEN_WIDTH / 6;
        }
    } else {
        
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat scale = (44 - offsetY) / 44;
        
        if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < 44) {
            self.titleView.y = - scrollView.contentOffset.y;
            self.backScrollView.frame = CGRectMake(0, -offsetY + 94, SCREEN_WIDTH, SCREEN_HEIGHT - 94 - 49 + offsetY);
            self.homeTableView.height = self.backScrollView.height;
            self.articleCollectionView.height = self.backScrollView.height;
            self.showTableView.height = self.backScrollView.height;
            self.titleImageView.alpha = scale;
            // 0 30 88 24
            CGFloat changeX = (SCREEN_WIDTH - 88) / 2 + (1 - scale) * 88 / 2;
            self.titleImageView.frame = CGRectMake(changeX, 30 * scale, 88 * scale, 24 * scale);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.backScrollView) {
        NSInteger index = self.backScrollView.contentOffset.x / SCREEN_WIDTH;
        for (NSInteger i = 0; i < self.titleArr.count; i++) {
            if (i == index) {
                [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
            } else {
                [self collectionView:self.titleCollectionView didDeselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            }
        }
    }
}


#pragma mark - 设置tableViewCell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.homeTableView) {
        CGFloat titleLabelHeight = 77;
        return SCREEN_WIDTH + titleLabelHeight;
    } else {
        CGFloat cellHeight = 223;
        return cellHeight;
    }
}
#pragma mark - 设置新作以及title的collectionView
- (void)setupArticleCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemMargin = 1;
    CGFloat itemWidth = (SCREEN_WIDTH - 2 * itemMargin) / 3;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumInteritemSpacing = itemMargin;
    layout.minimumLineSpacing = itemMargin;
    self.articleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.backScrollView.height) collectionViewLayout:layout];
    [self.articleCollectionView registerNib:[UINib nibWithNibName:@"YR_ArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:articleCollectionViewCellReuse];
    self.articleCollectionView.backgroundColor = [UIColor whiteColor];
    self.articleCollectionView.delegate = self;
    self.articleCollectionView.dataSource = self;
    [self.backScrollView addSubview:self.articleCollectionView];
    
    self.a_newArtsListModelArr = [NSMutableArray array];
    
    self.articleCollectionViewHeaderTool = [[YR_RefreshGiHeaderTool alloc] initWithScrollView:self.articleCollectionView requestBlock:^{
        [self.manager POST:@"http://ios1.artand.cn/discover/work/new?last_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.a_newArtsModel = [YR_NewArtsModel modelWithDict:responseObject];
            [self.a_newArtsListModelArr removeAllObjects];
            for (YR_NewArtsListModel *list in self.a_newArtsModel.list) {
                [self.a_newArtsListModelArr addObject:list];
            }
            [self.articleCollectionView reloadData];
            [self.articleCollectionView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
    
    self.articleCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self.manager POST:@"http://ios1.artand.cn/discover/work/new?last_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.a_newArtsModel = [YR_NewArtsModel modelWithDict:responseObject];
            for (YR_NewArtsListModel *list in self.a_newArtsModel.list) {
                [self.a_newArtsListModelArr addObject:list];
            }
            [self.articleCollectionView reloadData];
            [self.articleCollectionView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
}
#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.titleCollectionView) {
        return self.titleArr.count;
    } else {
        return self.a_newArtsListModelArr.count;
    }
}
#pragma mark - collectionView数据源代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.titleCollectionView) {
        YR_TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArr[indexPath.row];
        cell.titleLabel.textColor = [UIColor lightGrayColor];
        [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        
        return cell;
    } else {
        YR_ArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:articleCollectionViewCellReuse forIndexPath:indexPath];
        cell.articleBackView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
        NSString *picStr = [NSString stringWithFormat:@"http://work.artand.cn/%@!app.c360.webp", self.a_newArtsListModelArr[indexPath.row].pic.pid];
        [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:picStr]];
        return cell;
    }
}
#pragma mark - collectionView监听item点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.titleCollectionView) {
        CGFloat offsetX = indexPath.row * SCREEN_WIDTH;
        [self.backScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
        YR_TitleCollectionViewCell * cell = (YR_TitleCollectionViewCell *)[self.titleCollectionView cellForItemAtIndexPath:indexPath];
        cell.titleLabel.textColor = [UIColor blackColor];
        for (NSInteger i = 0; i < self.titleArr.count; i++) {
            if (i != indexPath.row) {
                [self collectionView:self.titleCollectionView didDeselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            }
        }
    } else {
        YR_ArtDetailViewController *artDetailVC = [[YR_ArtDetailViewController alloc] init];
        NSString *rowid = self.a_newArtsListModelArr[indexPath.row].row_id;
        artDetailVC.rowid = rowid;
        artDetailVC.imageAspectRatio = [self.a_newArtsListModelArr[indexPath.row].pic.h floatValue] / [self.a_newArtsListModelArr[indexPath.row].pic.w floatValue];
        [artDetailVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:artDetailVC animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.titleCollectionView) {
        YR_TitleCollectionViewCell * cell = (YR_TitleCollectionViewCell *)[self.titleCollectionView cellForItemAtIndexPath:indexPath];
            cell.titleLabel.textColor = [UIColor lightGrayColor];
    }
}


@end
