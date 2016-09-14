//
//  YR_PersonalPageViewController.m
//  Artand
//
//  Created by dllo on 16/9/9.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageViewController.h"
#import "UIView+Frame.h"
#import "YR_Macro.h"
#import "YR_ScrollView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "YR_EditorRecommendListModel.h"
#import "YR_EditorRecommendUserModel.h"
#import "Masonry.h"
#import "YR_PersonalPageModel.h"
#import "YR_PersonalPageOwnerModel.h"
#import "YR_PersonalPageHomeViewController.h"
#import "YR_PersonalPageBriefViewController.h"
#import "YR_PersonalPageArticleViewController.h"
#import "YR_PersonalPageLikedViewController.h"
#import "YR_PersonalPageSaleViewController.h"
#import "YR_PersonalPageGalleryViewController.h"
#import "YR_ShareViewTool.h"

@interface YR_PersonalPageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) YR_ScrollView *backScrollView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIView *backHomeView;
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) YR_ScrollView *pageScrollView;
@property (nonatomic, strong) UIButton *popBtn;
@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) YR_PersonalPageModel *personalPageModel;
@property (nonatomic, strong) YR_ScrollView *titleScrollView;
@property (nonatomic, strong) UIView *tintView;

@property (nonatomic, strong) YR_PersonalPageHomeViewController *homeVC;
@property (nonatomic, strong) YR__PersonalPageBriefViewController *briefVC;
@property (nonatomic, strong) YR_PersonalPageGalleryViewController *galleryVC;
@property (nonatomic, strong) YR_PersonalPageArticleViewController *articleVC;
@property (nonatomic, strong) YR_PersonalPageSaleViewController *saleVC;
@property (nonatomic, strong) YR_PersonalPageLikedViewController *likedVC;

@end

@implementation YR_PersonalPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupUI];
    [self handleData];
    [self createChildViewControllers];
}

- (void)setupUI {
    
    self.backScrollView = [[YR_ScrollView alloc] initWithFrame:self.view.bounds];
    self.backScrollView.contentSize = CGSizeMake(2 * SCREEN_WIDTH, 0);
    [self.view addSubview:self.backScrollView];
    self.backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.showsHorizontalScrollIndicator = NO;
    self.backScrollView.pagingEnabled = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.backScrollView setContentOffset:CGPointMake(50, 0) animated:YES];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.coverImageView.userInteractionEnabled = YES;
    self.coverImageView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.backScrollView addSubview:self.coverImageView];
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    coverView.alpha = 3;
    [self.backScrollView addSubview:coverView];
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.frame = CGRectMake(0, 20, 44, 44);
    [popBtn setImage:[UIImage imageNamed:@"coverpop"] forState:UIControlStateNormal];
    [coverView addSubview:popBtn];
    [popBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sharedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharedBtn.frame = CGRectMake(SCREEN_WIDTH - 44, 20, 44, 44);
    [sharedBtn setImage:[UIImage imageNamed:@"selfshare0"] forState:UIControlStateNormal];
    [coverView addSubview:sharedBtn];
    [sharedBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.nameLabel.centerX = self.view.centerX;
    self.nameLabel.centerY = self.view.centerY * 1.3;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:40];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [coverView addSubview:self.nameLabel];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.descLabel.centerX = self.view.centerX;
    self.descLabel.centerY = self.view.centerY * 1.4;
    self.descLabel.textColor = [UIColor whiteColor];
    self.descLabel.font = [UIFont systemFontOfSize:16];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    [coverView addSubview:self.descLabel];
    
    self.backHomeView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.backScrollView addSubview:self.backHomeView];
    
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 108)];
    [self.backHomeView addSubview:self.naviView];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.naviView addSubview:separateLine];
    
    
    self.popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.popBtn.frame = CGRectMake(0, 20, 44, 44);
    [self.popBtn setImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
    [self.popBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:self.popBtn];
    
    self.titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, SCREEN_WIDTH - 88, 44)];
    self.titleNameLabel.textColor = [UIColor blackColor];
    self.titleNameLabel.textAlignment = NSTextAlignmentCenter;
    self.titleNameLabel.font = [UIFont systemFontOfSize:18];
    [self.naviView addSubview:self.titleNameLabel];
    
    self.pageScrollView = [[YR_ScrollView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.backHomeView addSubview:self.pageScrollView];
    self.pageScrollView.delegate = self;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.pageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 6, 0);
    
    self.titleScrollView = [[YR_ScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    self.titleScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 1.5, 0);
    self.titleScrollView.backgroundColor = [UIColor whiteColor];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    [self.naviView addSubview:self.titleScrollView];
    
    self.tintView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 16, 41.5, SCREEN_WIDTH / 8, 2)];
    self.tintView.backgroundColor = [UIColor blackColor];
    [self.titleScrollView addSubview:self.tintView];
    
    UIView *secSeparateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
    secSeparateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.titleScrollView addSubview:secSeparateLine];
    
    NSArray *titleArr = @[@"主页", @"简介", @"作品集", @"文章", @"出售中", @"赞过的"];
    CGFloat btnWidth = SCREEN_WIDTH / 4;
    CGFloat btnHeight = 44;
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 10010 + i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
    }
}

- (void)changeView:(UIButton *)btn {
    
    [self.pageScrollView setContentOffset:CGPointMake((btn.tag - 10010) * SCREEN_WIDTH, 0) animated:YES];    
    if (btn.tag == 10013) {
        [self.titleScrollView setContentOffset:CGPointMake(SCREEN_WIDTH / 2, 0) animated:YES];
    } else if (btn.tag == 10012) {
        [self.titleScrollView setContentOffset:CGPointZero animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.tintView.centerX = scrollView.contentOffset.x / 4 + SCREEN_WIDTH / 8;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x >= 3 * SCREEN_WIDTH) {
        [self.titleScrollView setContentOffset:CGPointMake(SCREEN_WIDTH / 2, 0) animated:YES];
    } else if (scrollView.contentOffset.x <= 4 * SCREEN_WIDTH) {
        [self.titleScrollView setContentOffset:CGPointZero animated:YES];
    }
}


- (void)createChildViewControllers {
    
    self.homeVC = [[YR_PersonalPageHomeViewController alloc] init];
    self.briefVC = [[YR__PersonalPageBriefViewController alloc] init];
    self.galleryVC = [[YR_PersonalPageGalleryViewController alloc] init];
    self.articleVC = [[YR_PersonalPageArticleViewController alloc] init];
    self.saleVC = [[YR_PersonalPageSaleViewController alloc] init];
    self.likedVC = [[YR_PersonalPageLikedViewController alloc] init];
    
    NSArray *controllerArr = @[self.homeVC, self.briefVC, self.galleryVC, self.articleVC, self.saleVC, self.likedVC];
    
    for (UIViewController *controller in controllerArr) {
        [self addChildViewController:controller];
        controller.view.frame = CGRectMake(SCREEN_WIDTH * [controllerArr indexOfObject:controller], 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108);
        [self.pageScrollView addSubview:controller.view];
    }
}

- (void)handleData {
    
    // 点击cell请求 http://v1.artand.cn/user/24967 主页请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://v1.artand.cn/user/%@", self.uid];
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.personalPageModel = [YR_PersonalPageModel modelWithDict:responseObject];
        
        NSString *urlStr = [NSString stringWithFormat:@"http://cover.artand.cn/%@?imageView2/1/w/375/h/667%%7CimageMogr2/strip/interlace/1", self.personalPageModel.owner.cover];
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        self.descLabel.text = [NSString stringWithFormat:@"artand.cn/%@", self.personalPageModel.owner.domain];
        self.nameLabel.text = self.personalPageModel.owner.uname;
        self.titleNameLabel.text = self.personalPageModel.owner.uname;
        
        self.homeVC.personalPageModel = self.personalPageModel;
        self.briefVC.uid = self.personalPageModel.owner.uid;
        self.galleryVC.uid = self.personalPageModel.owner.uid;
        self.articleVC.uid = self.personalPageModel.owner.uid;
        self.saleVC.uid = self.personalPageModel.owner.uid;
        self.likedVC.uid = self.personalPageModel.owner.uid;
        
        [self.homeVC.homeTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)popAction:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction:(UIButton *)btn {
    
    YR_ShareViewTool *shareView = [[YR_ShareViewTool alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:shareView];
    
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}


@end
