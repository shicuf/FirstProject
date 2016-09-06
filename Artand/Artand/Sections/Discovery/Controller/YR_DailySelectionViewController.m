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

@interface YR_DailySelectionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YR_DailySelectionModel *dailySelectionModel;
@property (weak, nonatomic) IBOutlet UITableView *dailySelectionTableView;

@end

@implementation YR_DailySelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self handleData];
    
    [self.dailySelectionTableView registerNib:[UINib nibWithNibName:@"YR_DailyCollectionCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (void)handleData {
    
    // http://event.artand.cn/33852/e8da6d3b3e1d7712be77558c7ddb8b3c.jpg!n720
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://android.artand.cn/event/index?last_id=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dailySelectionModel = [YR_DailySelectionModel modelWithDict:responseObject];
        [self.dailySelectionTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 19;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_DailyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    NSString *str = [NSString stringWithFormat:@"http://event.artand.cn%@", self.dailySelectionModel.list[indexPath.row].pic];
    [cell.dailyCollectionImageView sd_setImageWithURL:[NSURL URLWithString:str]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCREEN_WIDTH / 2 + 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_CycleImageDetailViewController *cycleImageDetailVC = [[YR_CycleImageDetailViewController alloc] init];
    cycleImageDetailVC.titleStr = self.dailySelectionModel.list[indexPath.row].title;
    cycleImageDetailVC.detailUrl = [NSURL URLWithString:self.dailySelectionModel.list[indexPath.row].url];
    [self.navigationController pushViewController:cycleImageDetailVC animated:YES];
}
- (IBAction)popAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
