//
//  YR_FourSmallSectionsViewController.m
//  Artand
//
//  Created by Dendi on 9/3/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_FourSmallSectionsViewController.h"
#import "YR_ShowTableViewCell.h"
#import "AFNetworking.h"
#import "YR_ShowModel.h"
#import "YR_ShowListModel.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "YR_ShowUserModel.h"
#import "YR_ArticleWebViewController.h"
#import "MJRefresh.h"
#import "YR_PersonalPageViewController.h"


@interface YR_FourSmallSectionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) YR_ShowModel *fourSectionsModel;
@property (weak, nonatomic) IBOutlet UITableView *fourSelectionsTableView;
@property (nonatomic, strong) NSMutableArray<YR_ShowListModel *> *showListModelArr;

@end

@implementation YR_FourSmallSectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.titleStr;
    [self.fourSelectionsTableView registerNib:[UINib nibWithNibName:@"YR_ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    self.showListModelArr = [NSMutableArray array];
    [self handleData];
    [self  refreshData];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // http://ios1.artand.cn/discover/news?type=personage&last_id=0
    NSString *urlStr = [NSString stringWithFormat:@"http://ios1.artand.cn/discover/news?type=%@&last_id=0", self.typeStr];
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.fourSectionsModel = [YR_ShowModel modelWithDict:responseObject];
        for (YR_ShowListModel *list in self.fourSectionsModel.list) {
            [self.showListModelArr addObject:list];
        }
        [self.fourSelectionsTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)refreshData {
    
    self.fourSelectionsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *urlStr = [NSString stringWithFormat:@"http://ios1.artand.cn/discover/news?type=%@&last_id=0", self.typeStr];
        [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.fourSectionsModel = [YR_ShowModel modelWithDict:responseObject];
            [self.showListModelArr removeAllObjects];
            for (YR_ShowListModel *list in self.fourSectionsModel.list) {
                [self.showListModelArr addObject:list];
            }
            [self.fourSelectionsTableView reloadData];
            [self.fourSelectionsTableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
    
    self.fourSelectionsTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *urlStr = [NSString stringWithFormat:@"http://ios1.artand.cn/discover/news?type=%@&last_id=%@", self.typeStr, self.fourSectionsModel.last_id];
        [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.fourSectionsModel = [YR_ShowModel modelWithDict:responseObject];
            for (YR_ShowListModel *list in self.fourSectionsModel.list) {
                [self.showListModelArr addObject:list];
            }
            [self.fourSelectionsTableView reloadData];
            [self.fourSelectionsTableView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.showListModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
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
    [cell.descImageView setContentMode:UIViewContentModeScaleAspectFill];
    [cell.descImageView sd_setImageWithURL:[NSURL URLWithString:fullStr]];
    
    cell.btnBlock = ^{
        
        YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
        personalPageVC.uid = self.showListModelArr[indexPath.row].uid;
        personalPageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personalPageVC animated:YES];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 223;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArticleWebViewController *articleWebViewVC = [[YR_ArticleWebViewController alloc] init];
    articleWebViewVC.row_id = self.showListModelArr[indexPath.row].row_id;
    articleWebViewVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:articleWebViewVC animated:YES];
}

- (IBAction)popAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
