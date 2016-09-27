//
//  YR_SearchViewController.m
//  Artand
//
//  Created by dllo on 2016/9/21.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_SearchViewController.h"
#import "YR_Macro.h"
#import "UIView+Frame.h"
#import "YR_ArtDetailLikePersonCell.h"
#import "AFNetworking.h"
#import "YR_SearchArtistListModel.h"
#import "YR_SearchArtistModel.h"
#import "UIButton+WebCache.h"
#import "YR_PersonalPageViewController.h"
#import "YR_SearchWorkModel.h"
#import "YR_SearchArticleModel.h"
#import "YR_EditorRecommendTableViewCell.h"
#import "YR_SearchWorkListModel.h"
#import "YR_SearchWorkCateModel.h"
#import "YR_SearchWorkPicsModel.h"
#import "YR_SearchWorkSizeModel.h"
#import "YR_SearchWorkUserModel.h"
#import "NSString+YR_TimeInterval.h"
#import "YR_ArtDetailViewController.h"
#import "YR_SearchArticleCell.h"
#import "YR_SearchArticleListModel.h"
#import "YR_SearchArticleUserModel.h"
#import "UIImageView+WebCache.h"
#import "YR_ArticleWebViewController.h"

@interface YR_SearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UIView *tintView;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) UITableView *artistTableView;
@property (nonatomic, strong) UITableView *workTableView;
@property (nonatomic, strong) UITableView *articleTableView;

@property (nonatomic, strong) YR_SearchArtistModel *artistModel;
@property (nonatomic, strong) YR_SearchWorkModel *workModel;
@property (nonatomic, strong) YR_SearchArticleModel *articleModel;

@end

@implementation YR_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    [self setupTitleBtn];
    [self setupBackScrollView];
    [self setupArtistTableView];
    [self setupWorkTableView];
    [self setupArticleTableView];
}



- (void)setupSearchBar {
    
    self.view.backgroundColor = [UIColor whiteColor];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 28, SCREEN_WIDTH - 60 , 30)];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    searchBar.barTintColor = [UIColor whiteColor];
    for (UIView *obj in [searchBar subviews]) {
        for (UIView *objs in [obj subviews]) {
            if ([objs isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
                [objs removeFromSuperview];
            }
        }
        if ([obj isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
            [obj removeFromSuperview];
        }
    }
    UIOffset offect = {28, 0};//第一个值是水平偏移量，第二个是竖直方向的偏移量
    searchBar.searchTextPositionAdjustment = offect;
    
    UITextField *searchField=[searchBar valueForKey:@"_searchField"];
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    searchField.layer.cornerRadius = 1.0;
    searchField.leftViewMode=UITextFieldViewModeNever;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMaxX(searchBar.frame), 28, 50, 30);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
    imageView.frame = CGRectMake(15, 0, 18, 18);
    imageView.centerY = searchBar.height / 2;
    [searchBar addSubview:imageView];
}

- (void)cancelSearch:(UIButton *)btn {
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setupTitleBtn {
    
    NSArray *titleArr = @[@"找人", @"作品", @"文章"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * 80, 62, 80, 38);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = 10086 + i;
        [self.view addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
        }
    }
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, SCREEN_WIDTH, 0.5)];
    separatorLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:separatorLine];
    
    _tintView = [[UIView alloc] initWithFrame:CGRectMake(15, 98.5, 50, 1)];
    _tintView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tintView];
}

- (void)click:(UIButton *)btn {
    
    [UIView animateWithDuration:0.1 animations:^{
        _tintView.centerX = btn.centerX;
    }];
    
    for (int i = 0; i < 3; i++) {
        if (btn.tag - 10086 == i) {
            btn.selected = YES;
        } else {
            UIButton *button = [self.view viewWithTag:i + 10086];
            button.selected = NO;
        }
    }
    [self.backScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (btn.tag - 10086), 0) animated:YES];
}

- (void)setupBackScrollView {
    
    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];
    self.backScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backScrollView];
    self.backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
    self.backScrollView.delegate = self;
    self.backScrollView.pagingEnabled = YES;
}

- (void)setupArtistTableView {
    
    self.artistTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100) style:UITableViewStylePlain];
    self.artistTableView.delegate = self;
    self.artistTableView.dataSource = self;
    [self.artistTableView registerNib:[UINib nibWithNibName:@"YR_ArtDetailLikePersonCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [self.backScrollView addSubview:self.artistTableView];
}

- (void)setupWorkTableView {
    
    self.workTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100) style:UITableViewStylePlain];
    self.workTableView.delegate = self;
    self.workTableView.dataSource = self;
    [self.workTableView registerNib:[UINib nibWithNibName:@"YR_EditorRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"workCell"];
    [self.backScrollView addSubview:self.workTableView];
}

- (void)setupArticleTableView {
    
    self.articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(2 * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100) style:UITableViewStylePlain];
    self.articleTableView.delegate = self;
    self.articleTableView.dataSource = self;
    [self.articleTableView registerNib:[UINib nibWithNibName:@"YR_SearchArticleCell" bundle:nil] forCellReuseIdentifier:@"articleCell"];
    [self.backScrollView addSubview:self.articleTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.artistTableView) {
        
        return self.artistModel.list.count;
    } else if (tableView == self.workTableView) {
        return self.workModel.list.count;
    } else {
        return self.articleModel.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.artistTableView) {
        
        YR_ArtDetailLikePersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.locationLabel.text = self.artistModel.list[indexPath.row].uname;
        cell.nameLabel.text = self.artistModel.list[indexPath.row].city;
        if ([cell.nameLabel.text isEqualToString:@""]) {
            cell.locationImageView.hidden = YES;
        } else {
            cell.locationImageView.hidden = NO;
        }
        NSString *uidStr = self.artistModel.list[indexPath.row].uid;
        NSString *versionStr = self.artistModel.list[indexPath.row].version;
        NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
        [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
        cell.iconBtn.userInteractionEnabled = NO;
        
        return cell;
    } else if (tableView == self.workTableView) {
        
        YR_EditorRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *picStr = self.workModel.list[indexPath.row].pid;
        NSString *fullStr = [NSString stringWithFormat:@"%@%@!app.c540.webp", @"http://work.artand.cn/", picStr];
        // http://work.artand.cn/6az/lsz_-PzBcWBRF8Bpvudome4WLG9Y.jpg!app.c540.webp
        NSURL *picUrl = [NSURL URLWithString:fullStr];
        [cell.picBtn sd_setImageWithURL:picUrl forState:UIControlStateNormal];
        
        NSString *uidStr = self.workModel.list[indexPath.row].user.uid;
        NSString *versionStr = self.workModel.list[indexPath.row].user.version;
        NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
        [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
        
        cell.imageNameLabel.text = self.workModel.list[indexPath.row].name;
        cell.artistNameLabel.text = self.workModel.list[indexPath.row].user.uname;
        cell.locationLabel.text = self.workModel.list[indexPath.row].user.city;
        
        // 获取到更新的时间戳
        NSString *timeStr = self.workModel.list[indexPath.row].mtime;
        NSString *newStr = [timeStr updateTimeForTimeIntervalString:timeStr];
        cell.timeLabel.text = newStr;
        
        NSString *categoryStr = self.workModel.list[indexPath.row].cate.category;
        
        NSString *sizeW = [NSString stringWithFormat:@"%@", self.workModel.list[indexPath.row].size.w];
        NSString *sizeH = [NSString stringWithFormat:@"%@", self.workModel.list[indexPath.row].size.l];
        
        NSString *sizeLabelStr = [NSString stringWithFormat:@"%@ X %@", sizeW, sizeH];
        NSString *timesStr = self.workModel.list[indexPath.row].times;
        NSString *descStr = [[categoryStr stringByAppendingPathComponent:sizeLabelStr] stringByAppendingPathComponent:timesStr];
        NSString *priceStr = self.workModel.list[indexPath.row].price;
        if ([priceStr isEqualToString:@"0.00"]) {
            cell.imageDesLabel.text = [descStr stringByAppendingPathComponent:@"非卖品"];
        } else {
            cell.imageDesLabel.text = descStr;
        }
        // cell的block属性 添加点击方法
        cell.btnBlock = ^{
            
            YR_ArtDetailViewController *artDetailVC = [[YR_ArtDetailViewController alloc] init];
            
            // 拼接链接的字符串
            NSString *rowid = self.workModel.list[indexPath.row].row_id;
            artDetailVC.rowid = rowid;
            
            // 点击图片的高宽比
            artDetailVC.imageAspectRatio = [self.workModel.list[indexPath.row].h floatValue] / [self.workModel.list[indexPath.row].w floatValue];
            [artDetailVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:artDetailVC animated:YES];
        };
        cell.likeBtn.hidden = YES;
        cell.priceView.hidden = YES;
        
        return cell;
    } else {
        
        YR_SearchArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        // http://news.artand.cn/27/FhgBVPk65BUZsYGN3v_Lo-b3rDNE.jpg?imageView2/1/w/600/h/180%7CimageMogr2/strip/interlace/1
        NSString *imageUrlStr = [NSString stringWithFormat:@"http://news.artand.cn/%@?imageView2/1/w/600/h/180%%7CimageMogr2/strip/interlace/1", self.articleModel.list[indexPath.row].pid];
        [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
        cell.nameLabel.text = self.articleModel.list[indexPath.row].title;
        NSString *uidStr = self.articleModel.list[indexPath.row].user.uid;
        NSString *versionStr = self.articleModel.list[indexPath.row].user.version;
        NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
        [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
        cell.locationLabel.text = self.articleModel.list[indexPath.row].user.city;
        cell.artistNameLabel.text = self.articleModel.list[indexPath.row].user.uname;
        
        NSString *timeStr = self.articleModel.list[indexPath.row].mtime;
        NSString *newStr = [timeStr updateTimeForTimeIntervalString:timeStr];
        
        cell.artistDescLabel.text = newStr;
        cell.descLabel.text = self.articleModel.list[indexPath.row].desc;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.artistTableView) {
        
        YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
        personalPageVC.uid = self.artistModel.list[indexPath.row].uid;
        personalPageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personalPageVC animated:YES];
    }
    if (tableView == self.articleTableView) {
        YR_ArticleWebViewController *articleWebViewVC = [[YR_ArticleWebViewController alloc] init];
        articleWebViewVC.row_id = self.articleModel.list[indexPath.row].row_id;
        articleWebViewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:articleWebViewVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.workTableView) {
        CGFloat titleLabelHeight = 77;
        return SCREEN_WIDTH + titleLabelHeight;
    } else if (tableView == self.articleTableView) {
        return 330;
    } else {
        return 60;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.backScrollView) {
        
        int index = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self click:[self.view viewWithTag:index + 10086]];
    }
    
}

#pragma mark - searchBar代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // http://v1.artand.cn/search/index?q=1&last_id=0&type=work
    // http://v1.artand.cn/search/index?q=1&last_id=0&type=artist
    // http://v1.artand.cn/search/index?q=1&last_id=0&type=article
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *searchUrl = [NSString stringWithFormat:@"http://v1.artand.cn/search/index?q=%@&last_id=0&type=artist",searchText];
    NSString * encodingString = [searchUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:encodingString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.artistModel = [YR_SearchArtistModel modelWithDict:responseObject];
        [self.artistTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    NSString *searchWorkStr = [NSString stringWithFormat:@"http://v1.artand.cn/search/index?q=%@&last_id=0&type=work", searchText];
    NSString * encodingWorkStr = [searchWorkStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [manager POST:encodingWorkStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.workModel = [YR_SearchWorkModel modelWithDict:responseObject];
        [self.workTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    NSDictionary *header = @{@"HOST":@"v1.artand.cn",
                             @"Accept":@"*/*",
                             @"Content-Type":@"application/x-www-form-urlencoded",
                             @"Cookie":@"AQ=fXR1q6-letqxp3qtg3l1l4Kygtuyip2ms3ivZIaijmB9dJdmsaV7y7K6jq2Dn5jLgnyc27CIrqWyhcmrhXmSqIliha27k4qXvbeCaI6vdZSCfI6YsZ7HsbOFwJqGiZ2cfXSbra-Th86xp3-fhIto2w; PHPSESSID=bl30fmcgoiuda1c8hke3b5oj52",
                             @"User-Agent":@"Artand/1.8.0/iPhone/9.3.3//zh-cn",
                             @"Accept-Language":@"zh-cn",
                             @"Accept-Encoding":@"gzip, deflate",
                             @"Content-Length": @"161"};
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    for (NSString *key in header.allKeys) {
        [manager.requestSerializer setValue:[header valueForKey:key] forHTTPHeaderField:key];
    }
    

    
    
    
    NSDictionary *para = @{@"session_id":SESSION_ID};
    
    NSString *searchArticleStr = [NSString stringWithFormat:@"http://v1.artand.cn/search/index?q=%@&last_id=0&type=article", searchText];
    NSString * encodingArticleStr = [searchArticleStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [manager POST:encodingArticleStr parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.articleModel = [YR_SearchArticleModel modelWithDict:responseObject];
        [self.articleTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.view endEditing:YES];
}

@end
