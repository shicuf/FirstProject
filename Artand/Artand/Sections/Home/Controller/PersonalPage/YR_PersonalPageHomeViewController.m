//
//  YR_PersonalPageHomeViewController.m
//  Artand
//
//  Created by dllo on 16/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageHomeViewController.h"
#import "YR_PersonalPageHomeProfileCell.h"
#import "AFNetworking.h"
#import "YR_PersonalPageModel.h"
#import "YR_PersonalPageOwnerModel.h"
#import "UIImageView+WebCache.h"
#import "YR_PersonalPageHomeArtCell.h"
#import "YR_Macro.h"
#import "UIButton+WebCache.h"
#import "YR_PersonalPageListModel.h"
#import "YR_PersonalPagePicsModel.h"
#import "YR_PersonalPageCateModel.h"
#import "YR_ArtDetailViewController.h"

static NSString * const profileCellReuse = @"YR_PersonalPageHomeProfileCell";
static NSString * const artCellReuse = @"YR_PersonalPageHomeArtCell";


@interface YR_PersonalPageHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation YR_PersonalPageHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108) style:UITableViewStylePlain];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.homeTableView registerNib:[UINib nibWithNibName:@"YR_PersonalPageHomeProfileCell" bundle:nil] forCellReuseIdentifier:profileCellReuse];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"YR_PersonalPageHomeArtCell" bundle:nil] forCellReuseIdentifier:artCellReuse];
    [self.view addSubview:self.homeTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.personalPageModel.list.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        YR_PersonalPageHomeProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:profileCellReuse];
        
        NSString *uidStr = self.personalPageModel.owner.uid;
        NSString *versionStr = self.personalPageModel.owner.version;
        NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconStr]];
        
        cell.nameLabel.text = self.personalPageModel.owner.uname;
        cell.locationLabel.text = self.personalPageModel.owner.city;
        NSString *descStr = [NSString stringWithFormat:@"%@ 件作品 / %@ 位圈内人关注", self.personalPageModel.owner.num_work, self.personalPageModel.owner.num_followed];
        cell.followLabel.text = descStr;
        cell.descLabel.text = self.personalPageModel.owner.desc;
        
        return cell;
    } else {
        
        YR_PersonalPageHomeArtCell *cell = [tableView dequeueReusableCellWithIdentifier:artCellReuse];
        
        NSString *picStr = self.personalPageModel.list[indexPath.row - 1].pics[0].pid;
        NSString *fullStr = [NSString stringWithFormat:@"%@%@!app.c540.webp", @"http://work.artand.cn/", picStr];
        // http://work.artand.cn/6az/lsz_-PzBcWBRF8Bpvudome4WLG9Y.jpg!app.c540.webp
        NSURL *picUrl = [NSURL URLWithString:fullStr];
        [cell.imageBtn sd_setImageWithURL:picUrl forState:UIControlStateNormal];
        cell.nameLabel.text = self.personalPageModel.list[indexPath.row - 1].name;
        
        NSString *priceStr = self.personalPageModel.list[indexPath.row - 1].price;
        float price = [priceStr floatValue];
        if ([priceStr isEqualToString:@"0.00"]) {
            cell.priceView.hidden = YES;
        } else {
            cell.priceView.hidden = NO;
            if (price > 1000.0) {
                NSString *newPriceStr = [NSString stringWithFormat:@"¥%.2fK", price / 1000.0];
                cell.priceLabel.text = newPriceStr;
            } else {
                cell.priceLabel.text = priceStr;
            }
        }
        
        NSString *categoryStr = self.personalPageModel.list[indexPath.row - 1].cate.category;
        NSString *timesStr = self.personalPageModel.list[indexPath.row - 1].times;
        NSString *descStr = [categoryStr stringByAppendingPathComponent:timesStr];
        if ([priceStr isEqualToString:@"0.00"]) {
            cell.descLabel.text = [descStr stringByAppendingPathComponent:@"非卖品"];
        } else {
            cell.descLabel.text = descStr;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 350;
    } else {
        return SCREEN_WIDTH + 15;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 0) {
        YR_ArtDetailViewController *artDetailVC = [[YR_ArtDetailViewController alloc] init];
        
        // 拼接链接的字符串
        NSString *rowid = self.personalPageModel.list[indexPath.row - 1].row_id;
        artDetailVC.rowid = rowid;
        
        // 点击图片的高宽比
        artDetailVC.imageAspectRatio = [self.personalPageModel.list[indexPath.row - 1].pics[0].h floatValue] / [self.personalPageModel.list[indexPath.row - 1].pics[0].w floatValue];
        [artDetailVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:artDetailVC animated:YES];
    }
}



@end
