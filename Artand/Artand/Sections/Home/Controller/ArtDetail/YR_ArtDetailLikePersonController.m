//
//  YR_ArtDetailLikePersonController.m
//  Artand
//
//  Created by dllo on 2016/9/13.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailLikePersonController.h"
#import "YR_Macro.h"
#import "YR_ArtDetailLikePersonCell.h"
#import "YR_ArtDetailLikesModel.h"
#import "UIButton+WebCache.h"
#import "YR_PersonalPageViewController.h"

@interface YR_ArtDetailLikePersonController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *likePersonTableView;

@end

@implementation YR_ArtDetailLikePersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:naviView];
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.frame = CGRectMake(0, 20, 44, 44);
    [popBtn setImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
    [naviView addSubview:popBtn];
    [popBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, SCREEN_WIDTH - 88, 44)];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点赞用户";
    [naviView addSubview:label];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 10)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [naviView addSubview:separateLine];
    
    self.likePersonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.likePersonTableView.delegate = self;
    self.likePersonTableView.dataSource = self;
    [self.likePersonTableView registerNib:[UINib nibWithNibName:@"YR_ArtDetailLikePersonCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    self.likePersonTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.likePersonTableView];
}

- (void)popAction:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.likesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtDetailLikePersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    // uname cover city
    cell.locationLabel.text = self.likesArr[indexPath.row].uname;
    cell.nameLabel.text = self.likesArr[indexPath.row].city;
    
    NSString *uidStr = self.likesArr[indexPath.row].uid;
    NSString *versionStr = self.likesArr[indexPath.row].version;
    NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
    [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
    personalPageVC.uid = self.likesArr[indexPath.row].uid;
    personalPageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalPageVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}


@end
