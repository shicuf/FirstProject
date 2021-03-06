//
//  YR_DiscoveryViewController.m
//  Artand
//
//  Created by dllo on 16/8/27.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_DiscoveryViewController.h"
#import "YR_Macro.h"
#import "UIView+Frame.h"
#import "YR_DailySelectionViewController.h"
#import "YR_FourSmallSectionsViewController.h"
#import "YR_PurchaseViewController.h"
#import "YR_ArtistViewController.h"
#import "YR_FansViewController.h"
#import "YR_ArtMomentController.h"
#import "YR_SearchViewController.h"

@interface YR_DiscoveryViewController ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIScrollView *discoveryScrollView;

@property (nonatomic, strong) UIImageView *articleImageView;
@property (nonatomic, strong) UIImageView *dailySelectionImageView;
@property (nonatomic, strong) UIImageView *purchaseImageView;
@property (nonatomic, strong) UIImageView *artistImageView;
@property (nonatomic, strong) UIImageView *fansImageView;
@property (nonatomic, strong) UIImageView *personImageView;
@property (nonatomic, strong) UIImageView *readingImageView;
@property (nonatomic, strong) UIImageView *collectImageView;
@property (nonatomic, strong) UIImageView *appreciateImageView;

@end

@implementation YR_DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    [self setupTitleView];
    [self setupDiscoveryScrollView];
}

- (void)setupTitleView {
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    self.titleView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.titleView];
    
    CGFloat margin = 12;
    CGFloat searchBtnY = 28;
    CGFloat searchBtnHeight = 28;
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(margin, searchBtnY, SCREEN_WIDTH - 2 * margin, searchBtnHeight);
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1.0];
    [self.searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.searchBtn setAdjustsImageWhenHighlighted:NO];
    [self.searchBtn addTarget:self action:@selector(enterSearchView:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:self.searchBtn];
}

- (void)enterSearchView:(UIButton *)btn {
    
    YR_SearchViewController *searchVC = [YR_SearchViewController new];
    CATransition *transition=[CATransition animation];
    transition.type= kCATransitionFade;
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
}

- (void)setupDiscoveryScrollView {
    
    self.discoveryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64)];
//    self.discoveryScrollView.backgroundColor = [UIColor orangeColor];
    self.discoveryScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.discoveryScrollView];
    
    [self setupImageView];
}

- (void)setupImageView {
    
    CGFloat margin = 12;
    CGFloat longScale = 128.0 / 351.0;
    CGFloat shortScale = 187.0 / 344.0;
    CGFloat longImageWidth = SCREEN_WIDTH - 2 * margin;
    CGFloat shortImageWidth = (SCREEN_WIDTH - 3 * margin) / 2;
    CGFloat longImageHeight = longImageWidth * longScale;
    CGFloat shortImageHeight = shortImageWidth * shortScale;
    
    self.articleImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"artcircle"] frame:CGRectMake(margin, 0, longImageWidth, longImageHeight)];
    [self setupImageView:self.articleImageView action:@selector(pushArticle:)];
    
    self.dailySelectionImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"dailySelection"] frame:CGRectMake(margin, CGRectGetMaxY(self.articleImageView.frame) + margin, longImageWidth, longImageHeight)];
    [self setupImageView:self.dailySelectionImageView action:@selector(pushDailySelection:)];
    
    self.purchaseImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"purchase_bg"] frame:CGRectMake(margin, CGRectGetMaxY(self.dailySelectionImageView.frame) + margin, longImageWidth, longImageHeight)];
    [self setupImageView:self.purchaseImageView action:@selector(pushPurchase:)];
    
    self.artistImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"image_artist"] frame:CGRectMake(margin, CGRectGetMaxY(self.purchaseImageView.frame) + margin, longImageWidth, longImageHeight)];
    [self setupImageView:self.artistImageView action:@selector(pushArtist:)];
    
    self.fansImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"image_fans"] frame:CGRectMake(margin, CGRectGetMaxY(self.artistImageView.frame) + margin, longImageWidth, longImageHeight)];
    [self setupImageView:self.fansImageView action:@selector(pushFans:)];
    
    self.personImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"image_preson"] frame:CGRectMake(margin, CGRectGetMaxY(self.fansImageView.frame) + margin, shortImageWidth, shortImageHeight)];
    [self setupImageView:self.personImageView action:@selector(pushPerson:)];
    
    self.readingImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"image_read"] frame:CGRectMake(2 * margin + shortImageWidth, CGRectGetMaxY(self.fansImageView.frame) + margin, shortImageWidth, shortImageHeight)];
    [self setupImageView:self.readingImageView action:@selector(pushReading:)];
    
    self.collectImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"image_collect"] frame:CGRectMake(margin, CGRectGetMaxY(self.personImageView.frame) + margin, shortImageWidth, shortImageHeight)];
    [self setupImageView:self.collectImageView action:@selector(pushCollect:)];
    
    self.appreciateImageView = [self setupImageViewWithImage:[UIImage imageNamed:@"image_appreciate"] frame:CGRectMake(2 * margin + shortImageWidth, CGRectGetMaxY(self.personImageView.frame) + margin, shortImageWidth, shortImageHeight)];
    [self setupImageView:self.appreciateImageView action:@selector(pushAppreciate:)];
    
    self.discoveryScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.collectImageView.frame) + margin);
}

- (UIImageView *)setupImageViewWithImage:(UIImage *)image frame:(CGRect)frame {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    [self.discoveryScrollView addSubview:imageView];
    return imageView;
}

- (void)setupImageView:(UIImageView *)imageView action:(SEL)action {
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:action]];
}

- (void)pushArticle:(UITapGestureRecognizer *)tap {
    
    YR_ArtMomentController *artMomentVC = [[YR_ArtMomentController alloc] init];
    artMomentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:artMomentVC animated:YES];
}

- (void)pushDailySelection:(UITapGestureRecognizer *)tap {
    
    YR_DailySelectionViewController *dailySelectionVC = [[YR_DailySelectionViewController alloc] init];
    dailySelectionVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dailySelectionVC animated:YES];
}

- (void)pushPurchase:(UITapGestureRecognizer *)tap {
    
    YR_PurchaseViewController *purchaseVC = [[YR_PurchaseViewController alloc] init];
    purchaseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:purchaseVC animated:YES];
}

- (void)pushArtist:(UITapGestureRecognizer *)tap {
    
    YR_ArtistViewController *artistVC = [[YR_ArtistViewController alloc] init];
    artistVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:artistVC animated:YES];
}

- (void)pushFans:(UITapGestureRecognizer *)tap {
    
    YR_FansViewController *fansVC = [[YR_FansViewController alloc] init];
    fansVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fansVC animated:YES];
}

- (void)pushPerson:(UITapGestureRecognizer *)tap {
    
    [self fourSectionsActionWithTitle:@"人物" type:@"personage"];
}

- (void)pushReading:(UITapGestureRecognizer *)tap {
    
    [self fourSectionsActionWithTitle:@"艺术阅读" type:@"reading"];
}

- (void)pushCollect:(UITapGestureRecognizer *)tap {
    
    [self fourSectionsActionWithTitle:@"收藏与投资" type:@"invest"];
}

- (void)pushAppreciate:(UITapGestureRecognizer *)tap {
    
    [self fourSectionsActionWithTitle:@"艺术鉴赏" type:@"enjoy"];
}

- (void)fourSectionsActionWithTitle:(NSString *)title type:(NSString *)type {
    
    YR_FourSmallSectionsViewController *fourSmallSectionsVC = [[YR_FourSmallSectionsViewController alloc] init];
    fourSmallSectionsVC.typeStr = type;
    fourSmallSectionsVC.titleStr = title;
    fourSmallSectionsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fourSmallSectionsVC animated:YES];
}

@end
