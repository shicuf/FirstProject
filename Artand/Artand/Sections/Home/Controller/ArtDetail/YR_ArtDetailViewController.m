//
//  YR_ArtDetailViewController.m
//  Artand
//
//  Created by dllo on 16/9/1.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailViewController.h"
#import "YR_Macro.h"
#import "Masonry.h"
#import "YR_ArtDetailImageCell.h"
#import "UIView+Frame.h"
#import "YR_ArtDetailLikesModel.h"
#import "YR_ArtDetailModel.h"
#import "YR_ArtDetailOwnerModel.h"
#import "YR_ArtDetailPicModel.h"
#import "YR_ArtDetailPicsModel.h"
#import "YR_ArtDetailSizeModel.h"
#import "YR_ArtDetailWorkModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "YR_ArtDetailArtistCell.h"
#import "YR_ArtDetailRewardCell.h"
#import "YR_ArtDetailCommentCell.h"
#import "YR_PersonalPageViewController.h"
#import "YR_ArtDetailImageTransitionController.h"
#import "YR_PushTransitionAnimationTool.h"
#import "YR_PopTransitionAnimationTool.h"
#import "YR_ArtDetailLikePersonController.h"
#import "YR_ShareViewTool.h"
#import "NSString+YR_TimeInterval.h"

static NSString * const artDetailReuse = @"artDetailReuse";
static NSString * const artDetailImageViewCellReuse = @"artDetailImageViewCellReuse";
static NSString * const artDetailArtistReuse = @"artDetailArtistReuse";

@interface YR_ArtDetailViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIButton *popBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UITableView *artDetailTableView;
@property (nonatomic, strong) YR_ArtDetailModel *artDetailModel;
@property (nonatomic, strong) UIView *descView;
@property (nonatomic, strong) UILabel *browseLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UILabel *artDescLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIView *iconView;
@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) NSMutableArray *iconArray;

@property (nonatomic, strong) YR_ArtDetailImageTransitionController *vc;
@property (nonatomic, strong) UIView *shareView;

@end

@implementation YR_ArtDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self handleData];
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    // 页面消失的时候置空导航控制器的代理
//    self.navigationController.delegate = nil;
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // http://ios1.artand.cn/artid/293463
    NSString *rowid = self.rowid;
    NSString *url = [NSString stringWithFormat:@"http://ios1.artand.cn/artid/%@", rowid];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.artDetailModel = [YR_ArtDetailModel modelWithDict:responseObject];
        
        self.browseLabel.text = [NSString stringWithFormat:@"%@ 浏览", self.artDetailModel.work.num_view];
        self.nameLabel.text = self.artDetailModel.work.name;
        NSString *descStr = [NSString stringWithFormat:@"%@/%@/%@", self.artDetailModel.work.category, self.artDetailModel.work.size_label, self.artDetailModel.work.times];
        self.artDescLabel.text = descStr;
        NSString *priceStr = self.artDetailModel.work.price;
        if ([priceStr isEqualToString:@"0.00"]) {
            self.priceLabel.text = @"非卖品";
        } else {
            self.priceLabel.text = [NSString stringWithFormat:@"价格 ¥ %@", self.artDetailModel.work.price];
            NSString *keyword = [NSString stringWithFormat:@" ¥ %@", self.artDetailModel.work.price];
            NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
            NSRange range = [self.priceLabel.text rangeOfString:keyword];
            [temp addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            self.priceLabel.attributedText = temp;
        }
        
        NSString *timeStr = self.artDetailModel.work.mtime;
        NSString *newTimeStr = [timeStr updateTimeForTimeIntervalString:timeStr];
        
        
        
        self.artistLabel.text = [NSString stringWithFormat:@"%@ %@", self.artDetailModel.owner.uname, newTimeStr];
        
        self.iconArray = [NSMutableArray array];
        
        if (self.artDetailModel.likes.count >= floorf((SCREEN_WIDTH - 97) / 37.0)) {
            for (int i = 0; i < floorf((SCREEN_WIDTH - 97) / 37.0); i++) {
                [self handleIconCountWithIndex:i];
            }
        } else {
            for (int i = 0; i < self.artDetailModel.likes.count; i++) {
                [self handleIconCountWithIndex:i];
            }
        }
        [self.artDetailTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YRLog(@"%@", error);
    }];
}

- (void)handleIconCountWithIndex:(int)i {
    
    NSString *uidStr = self.artDetailModel.likes[i].uid;
    NSString *versionStr = self.artDetailModel.likes[i].version;
    NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
    [self.iconArray addObject:iconStr];
    [(UIButton *)[self.descView viewWithTag:10086 + i] sd_setImageWithURL:[NSURL URLWithString:self.iconArray[i]] forState:UIControlStateNormal];
}

- (void)setupUI {
    
    self.naviView = [[UIView alloc] init];
    self.naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.naviView];
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    self.popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviView addSubview:self.popBtn];
    [self.popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.width.height.mas_equalTo(44);
    }];
    [self.popBtn setImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
    [self.popBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.width.height.mas_equalTo(44);
    }];
    [self.moreBtn setImage:[UIImage imageNamed:@"Detailmore"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(detailMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.naviView addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    self.artDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.artDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.artDetailTableView.delegate = self;
    self.artDetailTableView.dataSource = self;
    self.artDetailTableView.backgroundColor = [UIColor whiteColor];
    [self.artDetailTableView registerNib:[UINib nibWithNibName:@"YR_ArtDetailImageCell" bundle:nil] forCellReuseIdentifier:artDetailImageViewCellReuse];
    [self.artDetailTableView registerNib:[UINib nibWithNibName:@"YR_ArtDetailArtistCell" bundle:nil] forCellReuseIdentifier:artDetailArtistReuse];
    [self.artDetailTableView registerNib:[UINib nibWithNibName:@"YR_ArtDetailRewardCell" bundle:nil] forCellReuseIdentifier:@"YR_ArtDetailRewardCell"];
    [self.artDetailTableView registerNib:[UINib nibWithNibName:@"YR_ArtDetailCommentCell" bundle:nil] forCellReuseIdentifier:artDetailReuse];
    
    [self.view addSubview:self.artDetailTableView];
    
    [self createDescView];
}

- (void)popAction:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)detailMoreAction:(UIButton *)btn {
    
    YR_ShareViewTool *shareView = [[YR_ShareViewTool alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:shareView];
}

- (void)cancel:(UIButton *)btn {
    
    [self.shareView removeFromSuperview];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        YR_ArtDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:artDetailImageViewCellReuse];
        
        // http://work.artand.cn/W8/Fs5RsgmqehQE5SXQf4eMezPy4WZ_.jpg!app.n720.webp
        
        NSString *imageURL = [NSString stringWithFormat:@"http://work.artand.cn/%@!app.n720.webp", self.artDetailModel.work.pic.pid];
        cell.imageView.contentMode = UIViewContentModeScaleToFill;
        [cell.artDetailImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
        
        
        // *****************************************************************************************************
        self.fromImageView = cell.artDetailImageView;
        self.newRect = [cell convertRect:cell.artDetailImageView.frame toView:self.view];
        
        __weak typeof(YR_ArtDetailImageCell *)weakCell = cell;
        cell.btnClickBlock = ^{
            
            self.vc = [YR_ArtDetailImageTransitionController new];
            self.navigationController.delegate = self;
            self.vc.image= weakCell.artDetailImageView.image;
            self.vc.imageWidth = weakCell.artDetailImageView.width;
            self.vc.imageHeight = weakCell.artDetailImageView.height;
            [self.navigationController pushViewController:self.vc animated:YES];
        };
        
        // *****************************************************************************************************

        return cell;
    } else if (indexPath.section == 1) {
        YR_ArtDetailArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:artDetailArtistReuse];
        
        NSString *uidStr = self.artDetailModel.owner.uid;
        NSString *versionStr = self.artDetailModel.owner.version;
        NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
        [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
        cell.nameLabel.text = self.artDetailModel.owner.uname;
        cell.descLabel.text = [NSString stringWithFormat:@"%@件作品 %@位粉丝", self.artDetailModel.owner.num_work, self.artDetailModel.owner.num_followed];
        return cell;
    } else if (indexPath.section == 2) {
        YR_ArtDetailRewardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YR_ArtDetailRewardCell"];
        return cell;
    } else {
        YR_ArtDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:artDetailReuse];
#warning 点击评论弹出键盘,tableview跟这向上滑动
        return cell;
    }
}

// *****************************************************************************************************

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        YR_PushTransitionAnimationTool *ta = [[YR_PushTransitionAnimationTool alloc] init];
        return ta;
    } else if (operation == UINavigationControllerOperationPop) {
        YR_PopTransitionAnimationTool *pa = [[YR_PopTransitionAnimationTool alloc] init];
        return pa;
    } else {
        
    }
    return nil;
}
// *****************************************************************************************************


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.descView;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
        personalPageVC.uid = self.artDetailModel.owner.uid;
        // 代理置空才能取消自定义push
        self.navigationController.delegate = nil;
        [self.navigationController pushViewController:personalPageVC animated:YES];
    }
}

- (void)createDescView {
    
    self.descView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 220)];
    self.descView.backgroundColor = [UIColor whiteColor];
    self.browseLabel = [[UILabel alloc] init];
    [self.descView addSubview:self.browseLabel];
    [self.browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(0);
    }];
    
    self.browseLabel.textColor = [UIColor darkGrayColor];
    self.browseLabel.font = [UIFont systemFontOfSize:11];
    
    UIImageView *eyeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eye"]];
    [self.descView addSubview:eyeImageView];
    [eyeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(11);
        make.trailing.mas_equalTo(self.browseLabel.mas_leading).mas_offset(-2);
        make.centerY.mas_equalTo(self.browseLabel);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.descView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(25);
    }];
    
    self.artistLabel = [[UILabel alloc] init];
    [self.descView addSubview:self.artistLabel];
    [self.artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(15);
    }];
    self.artistLabel.textColor = [UIColor darkGrayColor];
    self.artistLabel.font = [UIFont systemFontOfSize:12];
    
    self.artDescLabel = [[UILabel alloc] init];
    [self.descView addSubview:self.artDescLabel];
    [self.artDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.artistLabel.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(18);
    }];
    self.artDescLabel.font = [UIFont systemFontOfSize:14];
    
    self.priceLabel = [[UILabel alloc] init];
    [self.descView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.artDescLabel.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(20);
    }];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    
    UIView *horizontalLineView = [[UIView alloc] init];
    [self.descView addSubview:horizontalLineView];
    [horizontalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    horizontalLineView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.descView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(15);
        make.width.height.mas_equalTo(67);
    }];
    [self.likeBtn setImage:[UIImage imageNamed:@"unlikeHeart"] forState:UIControlStateNormal];
    [self.likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *verticalLineView = [[UIView alloc] init];
    [self.descView addSubview:verticalLineView];
    [verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.likeBtn.mas_trailing).mas_offset(0);
        make.centerY.mas_equalTo(self.likeBtn);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(27);
    }];
    verticalLineView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.descView addSubview:self.detailBtn];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(67);
        make.centerY.mas_equalTo(self.likeBtn);
    }];
    [self.detailBtn setImage:[UIImage imageNamed:@"push"] forState:UIControlStateNormal];
    [self.detailBtn addTarget:self action:@selector(pushLikePeople:) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconView = [[UIView alloc] init];
    [self.descView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.likeBtn.mas_trailing).mas_offset(0);
        make.trailing.mas_equalTo(self.detailBtn.mas_leading).mas_offset(0);
        make.height.mas_equalTo(67);
        make.centerY.mas_equalTo(self.likeBtn);
    }];
    
    // 计算头像在不同宽度屏幕上显示的个数
    CGFloat num = (SCREEN_WIDTH - 97) / 37.0;
    int iconCount = floorf(num);
    CGFloat margin = 10;
    CGFloat btnY = 20;
    CGFloat btnWidth = 27;
    for (int i = 0; i < iconCount; i++) {
        UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconBtn.frame = CGRectMake(margin + i * (margin + btnWidth), btnY, btnWidth, btnWidth);
        iconBtn.layer.cornerRadius = btnWidth / 2;
        iconBtn.layer.masksToBounds = YES;
        iconBtn.tag = 10086 + i;
        [iconBtn addTarget:self action:@selector(pushPersonalPage:) forControlEvents:UIControlEventTouchUpInside];
        [iconBtn setBackgroundColor:[UIColor whiteColor]];
        [self.iconView addSubview:iconBtn];
    }
}

- (void)pushPersonalPage:(UIButton *)btn {
    
    YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
    if ((btn.tag - 10086) < self.artDetailModel.likes.count) {
        personalPageVC.uid = self.artDetailModel.likes[btn.tag - 10086].uid;
        personalPageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personalPageVC animated:YES];
    }
}

- (void)pushLikePeople:(UIButton *)btn {
    
    YR_ArtDetailLikePersonController *likePersonVC = [[YR_ArtDetailLikePersonController alloc] init];
    likePersonVC.likesArr = self.artDetailModel.likes;
    [self.navigationController pushViewController:likePersonVC animated:YES];
}

- (void)likeAction:(UIButton *)btn {
    static BOOL isSelcted = NO;
    isSelcted = !isSelcted;
    if (isSelcted) {
        [self.likeBtn setImage:[UIImage imageNamed:@"likeHeart"] forState:UIControlStateNormal];
    } else {
        [self.likeBtn setImage:[UIImage imageNamed:@"unlikeHeart"] forState:UIControlStateNormal];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.1;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return 220;
    } else {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return SCREEN_WIDTH * self.imageAspectRatio;
    } else if (indexPath.section == 1) {
        return 73;
    } else if (indexPath.section == 2) {
        return 130;
    }else {
        return 150;
    }
    
}


@end
