//
//  YR_ArtistTableView.m
//  Artand
//
//  Created by Dendi on 9/4/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_ArtistTableView.h"
#import "YR_ArtistTableViewCell.h"
#import "YR_ArtistModel.h"
#import "YR_ArtistAuthModel.h"
#import "YR_ArtistListModel.h"
#import "YR_ArtistPicModel.h"
#import "YR_ArtistPicsModel.h"
#import "YR_ArtistWorksModel.h"
#import "YR_ArtistOutUserModel.h"
#import "YR_ArtistInUserModel.h"
#import "UIButton+WebCache.h"
#import "YR_PersonalPageViewController.h"

static NSString * const YR_ArtistTableViewCellReuse = @"YR_ArtistTableViewCellReuse";

@interface YR_ArtistTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation YR_ArtistTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self registerNib:[UINib nibWithNibName:@"YR_ArtistTableViewCell" bundle:nil] forCellReuseIdentifier:YR_ArtistTableViewCellReuse];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.delegate = self;
    self.dataSource = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YR_ArtistTableViewCellReuse];
    cell.nameLabel.text = self.artistModel.list[indexPath.row].user.uname;
    cell.locationLabel.text = self.artistModel.list[indexPath.row].user.city;
    cell.descLabel.text = [NSString stringWithFormat:@"%@件作品 %@位粉丝", self.artistModel.list[indexPath.row].user.num_work, self.artistModel.list[indexPath.row].user.num_followed];
    
    NSString *uidStr = self.artistModel.list[indexPath.row].user.uid;
    NSString *versionStr = self.artistModel.list[indexPath.row].user.version;
    NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
    [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
    [cell.artCollctionView reloadData]; // *********************
    cell.worksArray = self.artistModel.list[indexPath.row].works;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 232;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_PersonalPageViewController *personalPageVC = [[YR_PersonalPageViewController alloc] init];
    personalPageVC.uid = self.artistModel.list[indexPath.row].user.uid;
    personalPageVC.hidesBottomBarWhenPushed = YES;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[1] pushViewController:personalPageVC animated:YES];
}

@end
