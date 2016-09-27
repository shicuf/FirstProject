//
//  YR_ArtMomentController.m
//  Artand
//
//  Created by dllo on 2016/9/18.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtMomentController.h"
#import "YR_Macro.h"
#import "UIView+Frame.h"
#import "AFNetworking.h"
#import "YR_ArtCircleModel.h"
#import "YR_ArtCircleTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "YR_ArtCircleListModel.h"
#import "YR_ArtCirclePicsModel.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "MJRefresh.h"

@interface YR_ArtMomentController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIButton *popBtn;
@property (nonatomic, strong) UIImageView *artCircleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *notiBtn;
@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *iconLabelView;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UITableView *artMomentTableView;
@property (nonatomic, assign) BOOL isLight;

@property (nonatomic, strong) YR_ArtCircleModel *artCircleModel;
@property (nonatomic, strong) NSMutableArray<YR_ArtCircleListModel *> *listModelArr;

@end

@implementation YR_ArtMomentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self handleData];
    [self setupUI];
}

- (void)handleData {
    
//    http://ios1.artand.cn/collector_show1/index?last_id=0&uid=0
    
    self.manager = [AFHTTPSessionManager manager];
    [self.manager POST:@"http://ios1.artand.cn/collector_show1/index?last_id=0&uid=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.artCircleModel = [YR_ArtCircleModel modelWithDict:responseObject];
        for (YR_ArtCircleListModel *list in self.artCircleModel.list) {
            [self.listModelArr addObject:list];
        }
        [self.artMomentTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
//    [manager POST:@"http://ios1.artand.cn/collector_show1/index?last_id=102109&uid=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        self.artCircleModel = [YR_ArtCircleModel modelWithDict:responseObject];
//        NSLog(@"%@", self.artCircleModel.last_id);
//        [self.artMomentTableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    
//    [manager POST:@"http://ios1.artand.cn/collector_show1/index?last_id=102096&uid=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        self.artCircleModel = [YR_ArtCircleModel modelWithDict:responseObject];
//        NSLog(@"%@", self.artCircleModel.last_id);
//        [self.artMomentTableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
}

- (void)setupUI {
    
    _isLight = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.listModelArr = [NSMutableArray array];
    
    self.artMomentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.artMomentTableView.delegate = self;
    self.artMomentTableView.dataSource = self;
    [self.artMomentTableView registerClass:[YR_ArtCircleTableViewCell class] forCellReuseIdentifier:@"reuse"];
    self.artMomentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.artMomentTableView];
    
    self.artMomentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        NSString *urlStr = [NSString stringWithFormat:@"http://ios1.artand.cn/collector_show1/index?last_id=%@&uid=0", self.artCircleModel.last_id];
        
        [self.manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.artCircleModel = [YR_ArtCircleModel modelWithDict:responseObject];
            for (YR_ArtCircleListModel *list in self.artCircleModel.list) {
                [self.listModelArr addObject:list];
            }
            [self.artMomentTableView reloadData];
            [self.artMomentTableView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
    
    self.artMomentTableView.tableHeaderView = [self createHeaderView];
    self.artMomentTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.artMomentTableView.showsVerticalScrollIndicator = NO;
    
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVI_HEIGHT)];
    self.naviView.backgroundColor = [UIColor whiteColor];
    self.naviView.alpha = 0;
    [self.view addSubview:self.naviView];
    
    _popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _popBtn.frame = CGRectMake(0, 20, 44, 44);
    [_popBtn setImage:[UIImage imageNamed:@"coverpop"] forState:UIControlStateNormal];
    [_popBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_popBtn];
    
    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cameraBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 20, 50, 44);
    [_cameraBtn setImage:[UIImage imageNamed:@"ic_camera_white"] forState:UIControlStateNormal];
    [self.view addSubview:_cameraBtn];
    
    _notiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat notiWidth = 38;
    CGFloat notiHeight =44;
    _notiBtn.frame = CGRectMake(CGRectGetMinX(_cameraBtn.frame) - notiWidth, 20, notiWidth, notiHeight);
    [_notiBtn setImage:[UIImage imageNamed:@"ic_ring_white"] forState:UIControlStateNormal];
    [self.view addSubview:_notiBtn];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 90, 44)];
    titleView.centerX = self.view.centerX;
    titleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleView];
    
    _artCircleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_artcircle_white"]];
    _artCircleImageView.frame = CGRectMake(0, 0, 19, 20);
    _artCircleImageView.centerY = titleView.height / 2;
    [titleView addSubview:_artCircleImageView];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
    _titleLabel.text = @"艺术圈儿";
    _titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:_titleLabel];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.naviView.height - 0.5, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.naviView addSubview:separateLine];
}

- (UIView *)createHeaderView {
    
    NSString *iconImageURL = [NSString stringWithFormat:@"http://head.artand.cn/%@/%@/180", UID, VERSION];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconImageURL]]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 360)];
    

// http://thead.artand.cn/Lpe/FhHsUuktIFpl4dBFXCvY-79Q14Jr.jpeg!app.c720.webp
    // http://cover.artand.cn/LEZ/1!app.n720.jpeg
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:THEAD]];
    [view addSubview:self.backgroundImageView];
    
    self.iconLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 360)];
    [view addSubview:self.iconLabelView];
    
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconBtn.frame = CGRectMake(0, 0, 76, 76);
    self.iconBtn.layer.cornerRadius = self.iconBtn.width / 2;
    self.iconBtn.layer.borderWidth = 2;
    self.iconBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.center = CGPointMake(self.view.width / 2, CGRectGetMaxY(self.backgroundImageView.frame));
    self.iconBtn.backgroundColor = [UIColor lightGrayColor];
    [self.iconBtn setImage:image forState:UIControlStateNormal];
    [self.iconLabelView addSubview:self.iconBtn];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconBtn.frame) + 16, SCREEN_WIDTH, 20)];
    self.nameLabel.centerX = self.iconBtn.centerX;
    self.nameLabel.text = UNAME;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.iconLabelView addSubview:self.nameLabel];
    
    view.height = CGRectGetMaxY(self.nameLabel.frame) + 10;
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.listModel = self.listModelArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [YR_ArtCircleTableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 0) {
        self.naviView.alpha = 1;
        [self.popBtn setImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
        [self.notiBtn setImage:[UIImage imageNamed:@"ic_ring_black"] forState:UIControlStateNormal];
        [self.cameraBtn setImage:[UIImage imageNamed:@"ic_camera_black"] forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor blackColor];
        self.artCircleImageView.image = [UIImage imageNamed:@"ic_artcircle_black"];
    } else {
        self.naviView.alpha = 0;
        [self.popBtn setImage:[UIImage imageNamed:@"coverpop"] forState:UIControlStateNormal];
        [self.notiBtn setImage:[UIImage imageNamed:@"ic_ring_white"] forState:UIControlStateNormal];
        [self.cameraBtn setImage:[UIImage imageNamed:@"ic_camera_white"] forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.artCircleImageView.image = [UIImage imageNamed:@"ic_artcircle_white"];
    }
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    if (offset_Y <= 0) {
        _isLight = YES;
        
        CGFloat add_height = -offset_Y;
        CGFloat scale = (180 + add_height) / 180.0f;
        self.backgroundImageView.frame = CGRectMake(-(SCREEN_WIDTH * scale - SCREEN_WIDTH) / 2.0f, -add_height, SCREEN_WIDTH * scale, 180 + add_height);
    } else {
        _isLight = NO;
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (_isLight) {
        return 1;
    } else {
        return 0;
    }
    return 0;
}

- (void)popAction:(UIButton *)btn {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
