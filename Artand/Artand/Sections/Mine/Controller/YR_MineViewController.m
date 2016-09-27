//
//  YR_MineViewController.m
//  Artand
//
//  Created by dllo on 16/8/27.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_MineViewController.h"
#import "YR_Macro.h"
#import "UIView+Frame.h"
#import "YR_MineSettingController.h"
#import "YR_MineWalletController.h"
#import "YR_MineOrderController.h"
#import "YR_BaseMineDetailController.h"
#import "YR_MineAccountController.h"
#import "YR_MineContactController.h"
#import "YR_PersonalPageViewController.h"
#import "UIImageView+WebCache.h"
#import "SelfSizeTool.h"

static CGFloat const iconWidth = 32;
static CGFloat const viewMargin = 10;
static CGFloat const viewHeight = 60;

@interface YR_MineViewController ()

@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) UIView *accountView;
@property (nonatomic, strong) UIView *myPageView;
@property (nonatomic, strong) UIView *contactView;
@property (nonatomic, strong) UIView *orderView;
@property (nonatomic, strong) UIView *walletView;
@property (nonatomic, strong) UIView *applyView;
@property (nonatomic, strong) UIView *settingView;

@property (nonatomic, strong) UIImageView *statementImageView;

@end

@implementation YR_MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVI_HEIGHT)];
    naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:naviView];
    UIView *naviLine = [[UIView alloc] initWithFrame:CGRectMake(0, naviView.height - 0.5, SCREEN_WIDTH, 0.5)];
    naviLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [naviView addSubview:naviLine];
    
    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVI_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_HEIGHT - TAB_HEIGHT)];
    self.backScrollView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    [self.view addSubview:self.backScrollView];
    
//    NSString *titleName = [[NSUserDefaults standardUserDefaults] objectForKey:@"uname"];
    NSString *iconImageURL = [NSString stringWithFormat:@"http://head.artand.cn/%@/%@/180", UID, VERSION];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconImageURL]]];
    self.accountView = [self createSectionViewWithFrame:CGRectMake(0, viewMargin, SCREEN_WIDTH, viewHeight + 20) size:CGSizeMake(50, 50) iconImage:image action:@selector(pushAccount) title:UNAME];
    
    self.myPageView = [self createSectionViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.accountView.frame) + viewMargin, SCREEN_WIDTH, viewHeight) size:CGSizeMake(iconWidth, iconWidth) iconImage:[UIImage imageNamed:@"self0"] action:@selector(pushMyPage) title:@"我的主页"];
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.myPageView.height - 0.5, SCREEN_WIDTH - 15, 0.5)];
    separatorLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.myPageView addSubview:separatorLine];
    self.contactView = [self createSectionViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.myPageView.frame), SCREEN_WIDTH, viewHeight) size:CGSizeMake(iconWidth, iconWidth) iconImage:[UIImage imageNamed:@"self1"] action:@selector(pushContact) title:@"联系人"];
    self.orderView = [self createSectionViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactView.frame) + viewMargin, SCREEN_WIDTH, viewHeight) size:CGSizeMake(iconWidth, iconWidth) iconImage:[UIImage imageNamed:@"self2"] action:@selector(pushOrder) title:@"订单"];
    self.walletView = [self createSectionViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderView.frame) + viewMargin, SCREEN_WIDTH, viewHeight) size:CGSizeMake(iconWidth, iconWidth) iconImage:[UIImage imageNamed:@"self3"] action:@selector(pushWallet) title:@"钱包"];
    self.applyView = [self createSectionViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.walletView.frame) + viewMargin, SCREEN_WIDTH, viewHeight) size:CGSizeMake(iconWidth, iconWidth) iconImage:[UIImage imageNamed:@"icon_me_online"] action:@selector(pushApply) title:@"申请在线销售"];
    self.settingView = [self createSectionViewWithFrame:CGRectMake(0, CGRectGetMaxY(self.applyView.frame) + viewMargin, SCREEN_WIDTH, viewHeight) size:CGSizeMake(iconWidth, iconWidth) iconImage:[UIImage imageNamed:@"self4"] action:@selector(pushSetting) title:@"设置"];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.settingView.frame) + 13, SCREEN_WIDTH, 20)];
    versionLabel.text = @"版本号:1.0";
    versionLabel.textColor = [UIColor darkGrayColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:12];
    [self.backScrollView addSubview:versionLabel];
    
    self.backScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(versionLabel.frame) + 20);
    
}

- (UIView *)createSectionViewWithFrame:(CGRect)frame size:(CGSize)size iconImage:(UIImage *)iconImage action:(SEL)action title:(NSString *)title {
    
    UIView *sectionView = [[UIView alloc] initWithFrame:frame];
    sectionView.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:sectionView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
    iconImageView.layer.cornerRadius = size.width / 2;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.frame = CGRectMake(15, 0, iconWidth, iconWidth);
    iconImageView.size = size;
    iconImageView.centerY = sectionView.height / 2;
    [sectionView addSubview:iconImageView];
    
    UIImageView *disclosureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"push"]];
    disclosureImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 0, 9, 16);
    disclosureImageView.centerY = sectionView.height / 2;
    [sectionView addSubview:disclosureImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 15, 0, SCREEN_WIDTH / 2, 22)];
    titleLabel.centerY = sectionView.height / 2;
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [sectionView addSubview:titleLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [sectionView addGestureRecognizer:tap];
    
    return sectionView;
}

- (void)pushAccount {
    
    [self pushActionWithController:[YR_MineAccountController new] title:@"个人资料"];
}

- (void)pushMyPage {
    
    YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
    personalPageVC.uid = UID;
    personalPageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalPageVC animated:YES];
    
}

- (void)pushContact {
    
    [self pushActionWithController:[YR_MineContactController new] title:nil];
}

- (void)pushOrder {
    
    [self pushActionWithController:[YR_MineOrderController new] title:@"我的订单"];
}

- (void)pushWallet {
    
    [self pushActionWithController:[YR_MineWalletController new] title:@"钱包"];
}

- (void)pushApply {
    
    [self createApplyView];
}

- (void)createApplyView {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    UIView *applyBackView = [[UIView alloc] initWithFrame:SCREEN_RECT];
    [self.view addSubview:applyBackView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = applyBackView.frame;
    btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [applyBackView addSubview:btn];
    [btn addTarget:self action:@selector(removeApplyView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *applyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, SCREEN_HEIGHT / 2)];
    applyView.layer.cornerRadius = 5;
    applyView.layer.masksToBounds = YES;
    applyView.centerX = self.view.centerX;
    applyView.centerY = self.view.centerY - NAVI_HEIGHT / 2;
    applyView.backgroundColor = [UIColor whiteColor];
    [applyBackView addSubview:applyView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, applyView.width, 20)];
    titleLabel.text = @"什么是Artand线上担保交易?";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [applyView addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 20, applyView.width - 20, 200)];
    contentLabel.numberOfLines = 0;
    contentLabel.text = @" 1，同意并确认 [Artand销售服务和结算协议]。\n2，填写真实有效的作品价格。\n3，Artand会收取作品售出价格的5%作为服务费,以抵扣画款在第三方平台转付过程中所产生的费用。\n请保证在Artand平台进行支付，否则Artand将无法保证您的交易安全。";
    CGFloat height = [SelfSizeTool selfSizeHeightWithString:contentLabel.text width:contentLabel.width font:[UIFont systemFontOfSize:17]];
    contentLabel.height = height;
    contentLabel.textColor =[UIColor darkGrayColor];
    contentLabel.font = [UIFont systemFontOfSize:16];
    [applyView addSubview:contentLabel];
    
    UILabel *delegateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(contentLabel.frame) + 2, applyView.width, 30)];
    delegateLabel.text = @"Artand代理销售服务和结算协议";
    delegateLabel.font = [UIFont systemFontOfSize:14];
    [applyView addSubview:delegateLabel];
    
    UIButton *delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delegateBtn.frame = delegateLabel.frame;
    [delegateBtn addTarget:self action:@selector(delegateDetail:) forControlEvents:UIControlEventTouchUpInside];
    [applyView addSubview:delegateBtn];
    
    
    // rgba(0.32, 0.52, 0.74, 1)
    delegateLabel.textColor = [UIColor colorWithRed:0.32 green:0.52 blue:0.74 alpha:1.0];
    
    _statementImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_statement_checked"]];
    _statementImageView.frame = CGRectMake(15, 0, 14, 14);
    _statementImageView.centerY = delegateLabel.centerY;
    [applyView addSubview:_statementImageView];
    
    UIButton *statementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    statementBtn.frame = CGRectMake(0, 0, 30, 30);
    statementBtn.centerY = delegateLabel.centerY;
    [statementBtn addTarget:self action:@selector(checkType:) forControlEvents:UIControlEventTouchUpInside];
    [applyView addSubview:statementBtn];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(statementBtn.frame) + 5, applyView.width - 20, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [applyView addSubview:separateLine];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(15,  CGRectGetMaxY(separateLine.frame) + 12, applyView.width - 30, 30);
    [agreeBtn setTitle:@"同意并继续" forState:UIControlStateNormal];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    agreeBtn.backgroundColor = [UIColor blackColor];
    agreeBtn.layer.cornerRadius = 5;
    agreeBtn.layer.masksToBounds = YES;
    [applyView addSubview:agreeBtn];
    
    applyView.height = CGRectGetMaxY(agreeBtn.frame) + 30;
}

- (void)delegateDetail:(UIButton *)btn {
    
    YRLog(@"详情");
}

- (void)checkType:(UIButton *)btn {
    
    YRLog(@"check");
    
    static BOOL isSelcted = NO;
    isSelcted = !isSelcted;
    if (isSelcted) {
        _statementImageView.image = [UIImage imageNamed:@"ic_statement_unchecked"];
    } else {
        _statementImageView.image = [UIImage imageNamed:@"ic_statement_checked"];
    }
}

- (void)removeApplyView:(UIButton *)btn {
    
    [btn.superview removeFromSuperview];
}

- (void)pushSetting {
    
    [self pushActionWithController:[YR_MineSettingController new] title:@"设置"];
}

- (void)pushActionWithController:(YR_BaseMineDetailController *)VC title:(NSString *)titleStr {
    
    VC.titleStr = titleStr;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

@end
