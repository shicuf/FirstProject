//
//  YR_DailySelectionViewController.m
//  Artand
//
//  Created by dllo on 16/9/3.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_DailySelectionViewController.h"
#import "YR_DailyCollectionCell.h"
#import "YR_Macro.h"
#import "AFNetworking.h"
#import "YR_DailySelectionModel.h"
#import "UIImageView+WebCache.h"
#import "YR_DailySelectionListModel.h"
#import "YR_CycleImageDetailViewController.h"
#import "MJRefresh.h"
#import "YR_RefreshGiHeaderTool.h"

@interface YR_DailySelectionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YR_DailySelectionModel *dailySelectionModel;
@property (weak, nonatomic) IBOutlet UITableView *dailySelectionTableView;
@property (nonatomic, strong) NSMutableArray<YR_DailySelectionListModel *> *dailySelectionListModelArr;
@property (nonatomic, strong) YR_RefreshGiHeaderTool *dailySelectionCollectionViewHeaderTool;

@end

@implementation YR_DailySelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dailySelectionListModelArr = [NSMutableArray array];
    [self.dailySelectionTableView registerNib:[UINib nibWithNibName:@"YR_DailyCollectionCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [self handleData];
    [self refreshData];
}

- (void)handleData {
    
    // http://event.artand.cn/33852/e8da6d3b3e1d7712be77558c7ddb8b3c.jpg!n720
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://android.artand.cn/event/index?last_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dailySelectionModel = [YR_DailySelectionModel modelWithDict:responseObject];
        for (YR_DailySelectionListModel *list in self.dailySelectionModel.list) {
            [self.dailySelectionListModelArr addObject:list];
        }
        [self.dailySelectionTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)refreshData {
    
    self.dailySelectionCollectionViewHeaderTool = [[YR_RefreshGiHeaderTool alloc] initWithScrollView:self.dailySelectionTableView requestBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:@"http://android.artand.cn/event/index?last_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.dailySelectionModel = [YR_DailySelectionModel modelWithDict:responseObject];
            [self.dailySelectionListModelArr removeAllObjects];
            for (YR_DailySelectionListModel *list in self.dailySelectionModel.list) {
                [self.dailySelectionListModelArr addObject:list];
            }
            [self.dailySelectionTableView reloadData];
            [self.dailySelectionTableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
    
    self.dailySelectionTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *urlStr = [NSString stringWithFormat:@"http://android.artand.cn/event/index?last_id=%@", self.dailySelectionModel.last_id];
        [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.dailySelectionModel = [YR_DailySelectionModel modelWithDict:responseObject];
            for (YR_DailySelectionListModel *list in self.dailySelectionModel.list) {
                [self.dailySelectionListModelArr addObject:list];
            }
            [self.dailySelectionTableView reloadData];
            [self.dailySelectionTableView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dailySelectionListModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_DailyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    NSString *str = [NSString stringWithFormat:@"http://event.artand.cn%@", self.dailySelectionListModelArr[indexPath.row].pic];
    [cell.dailyCollectionImageView sd_setImageWithURL:[NSURL URLWithString:str]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCREEN_WIDTH / 2 + 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_CycleImageDetailViewController *cycleImageDetailVC = [[YR_CycleImageDetailViewController alloc] init];
    cycleImageDetailVC.titleStr = self.dailySelectionListModelArr[indexPath.row].title;
    cycleImageDetailVC.detailUrl = [NSURL URLWithString:self.dailySelectionListModelArr[indexPath.row].url];
    [self.navigationController pushViewController:cycleImageDetailVC animated:YES];
}
- (IBAction)popAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
