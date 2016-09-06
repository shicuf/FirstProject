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


@interface YR_FourSmallSectionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) YR_ShowModel *fourSectionsModel;
@property (weak, nonatomic) IBOutlet UITableView *fourSelectionsTableView;

@end

@implementation YR_FourSmallSectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self handleData];
    self.titleLabel.text = self.titleStr;
    [self.fourSelectionsTableView registerNib:[UINib nibWithNibName:@"YR_ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // http://ios1.artand.cn/discover/news?type=personage&last_id=0
    NSString *urlStr = [NSString stringWithFormat:@"http://ios1.artand.cn/discover/news?type=%@&last_id=0", self.typeStr];
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.fourSectionsModel = [YR_ShowModel modelWithDict:responseObject];
        [self.fourSelectionsTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.fourSectionsModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.descLabel.text = self.fourSectionsModel.list[indexPath.row].desc;
    cell.titleLabel.text = self.fourSectionsModel.list[indexPath.row].title;
    cell.nameLabel.text = self.fourSectionsModel.list[indexPath.row].user.uname;
    cell.locationLabel.text = self.fourSectionsModel.list[indexPath.row].user.city;
    NSString *likeStr = [NSString stringWithFormat:@"%@", self.fourSectionsModel.list[indexPath.row].num_liked];
    [cell.likeBtn setTitle:likeStr forState:UIControlStateNormal];
    
    NSString *uidStr = self.fourSectionsModel.list[indexPath.row].user.uid;
    NSString *versionStr = self.fourSectionsModel.list[indexPath.row].user.version;
    NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
    [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
    NSString *coverStr = self.fourSectionsModel.list[indexPath.row].pid;
    NSString *fullStr = [NSString stringWithFormat:@"http://news.artand.cn/%@?imageView2/1/w/600/h/180%%7CimageMogr2/strip/interlace/1", coverStr];
    [cell.descImageView setContentMode:UIViewContentModeScaleAspectFill];
    [cell.descImageView sd_setImageWithURL:[NSURL URLWithString:fullStr]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 223;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArticleWebViewController *webViewVC = [[YR_ArticleWebViewController alloc] init];
    [self.navigationController pushViewController:webViewVC animated:YES];
}

@end
