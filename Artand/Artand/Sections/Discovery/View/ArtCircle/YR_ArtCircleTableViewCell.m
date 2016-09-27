//
//  YR_ArtCircleTableViewCell.m
//  Artand
//
//  Created by dllo on 2016/9/18.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArtCircleTableViewCell.h"
#import "YR_Macro.h"
#import "Masonry.h"
#import "YR_ArtCircleListModel.h"
#import "YR_ArtCirclePicsModel.h"

#import "UIButton+WebCache.h"
#import "YR_ArtCircleInUserModel.h"
#import "YR_ArtCircleOutUserModel.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "YR_ArtCircleCollectionViewCell.h"
#import "NSString+YR_TimeInterval.h"
#import "SelfSizeTool.h"

#define HEIGHT width * [self.listModel.pics[0].h floatValue] / [self.listModel.pics[0].w floatValue]

@interface YR_ArtCircleTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UIImageView *vipIcon;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *imageCollectionView;

@property (nonatomic, strong) UIView *momentActionView;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *browseLabel;

@end


@implementation YR_ArtCircleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    
    self.infoView = [UIView new];
    [self.contentView addSubview:self.infoView];
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconBtn.layer.cornerRadius = 20;
    self.iconBtn.layer.masksToBounds = YES;
    [self.infoView addSubview:self.iconBtn];
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.infoView addSubview:self.nameLabel];
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.text = @"14分钟前";
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.infoView addSubview:self.timeLabel];
    //    self.locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"workDetailLocation"]];
    [self.infoView addSubview:self.locationIcon];
    //    self.vipIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"role1"]];
    [self.infoView addSubview:self.vipIcon];
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.font = [UIFont systemFontOfSize:16];
    self.descLabel.numberOfLines = 0;
    [self.contentView addSubview:self.descLabel];
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"YR_ArtCircleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"reuse"];
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imageCollectionView];
    
    self.momentActionView = [[UIView alloc] init];
    [self.contentView addSubview:self.momentActionView];
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setImage:[UIImage imageNamed:@"ic_unlike"] forState:UIControlStateNormal];
    [self.momentActionView addSubview:self.likeBtn];
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setImage:[UIImage imageNamed:@"ic_commet"] forState:UIControlStateNormal];
    [self.momentActionView addSubview:self.commentBtn];
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setImage:[UIImage imageNamed:@"ic_share"] forState:UIControlStateNormal];
    [self.momentActionView addSubview:self.shareBtn];
    self.browseLabel = [[UILabel alloc] init];
    self.browseLabel.textColor = [UIColor lightGrayColor];
    self.browseLabel.font = [UIFont systemFontOfSize:12];
    self.browseLabel.textAlignment = NSTextAlignmentRight;
    [self.momentActionView addSubview:self.browseLabel];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = SCREEN_WIDTH - 85;
    self.infoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    self.iconBtn.frame = CGRectMake(15, 0, 40, 40);
    self.nameLabel.frame = CGRectMake(65, 0, 100, 16);
    self.timeLabel.frame = CGRectMake(65, CGRectGetMaxY(self.nameLabel.frame) + 10, 100, 10);
    self.descLabel.frame = CGRectMake(65, CGRectGetMaxY(self.timeLabel.frame) + 15, SCREEN_WIDTH - 100, 20);
    self.descLabel.numberOfLines = 0;
    self.descLabel.height = [SelfSizeTool selfSizeHeightWithString:self.listModel.content width:SCREEN_WIDTH - 100 font:[UIFont systemFontOfSize:16]];
    
    if (self.listModel.pics.count == 0) {
        
        self.imageCollectionView.frame = CGRectZero;
    } else if (self.listModel.pics.count == 1) {
        
        if ([self.listModel.pics[0].w floatValue] < [self.listModel.pics[0].h floatValue]) {
            
            CGFloat itemHeight = SCREEN_HEIGHT / 2;
            CGFloat itemWidth = itemHeight * [self.listModel.pics[0].w floatValue] / [self.listModel.pics[0].h floatValue];
            self.layout.itemSize = CGSizeMake(itemWidth, itemHeight);
            if ([self.descLabel.text isEqualToString:@""]) {
                self.imageCollectionView.frame = CGRectMake(65, self.descLabel.y, itemWidth, itemHeight);
            } else {
                self.imageCollectionView.frame = CGRectMake(65, CGRectGetMaxY(self.descLabel.frame) + 15, itemWidth, itemHeight);
            }
        } else if ([self.listModel.pics[0].w floatValue] >= [self.listModel.pics[0].h floatValue]) {
            self.layout.itemSize = CGSizeMake(width, HEIGHT);
            if ([self.descLabel.text isEqualToString:@""]) {
                self.imageCollectionView.frame = CGRectMake(65, self.descLabel.y, width, HEIGHT);
            } else {
             
                self.imageCollectionView.frame = CGRectMake(65, CGRectGetMaxY(self.descLabel.frame) + 15, width, HEIGHT);
            }
        }
        
        
    } else {
        CGFloat margin = 3;
        CGFloat itemWidth = ((SCREEN_WIDTH - 85) - margin * 2) / 3;
        self.layout.minimumLineSpacing = margin;
        self.layout.minimumInteritemSpacing = margin;
        self.layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        CGFloat collectionViewHeight = 0;
        int count = (int)self.listModel.pics.count;
        if (count == 2 | count == 3) {
            collectionViewHeight = itemWidth;
        } else if (count == 4 | count == 5 | count == 6) {
            collectionViewHeight = 2 * itemWidth + margin;
        } else {
            collectionViewHeight = 3 * itemWidth + 2 * margin;
        }
        
        
        
        if ([self.descLabel.text isEqualToString:@""]) {
            
            
            self.imageCollectionView.frame = CGRectMake(65, self.descLabel.y, width, collectionViewHeight);
        } else {
            self.imageCollectionView.frame = CGRectMake(65, CGRectGetMaxY(self.descLabel.frame) + 15, width, collectionViewHeight);
        }
    }
    
    self.momentActionView.frame = CGRectMake(65, CGRectGetMaxY(self.imageCollectionView.frame), SCREEN_WIDTH - 85, 40);
    self.likeBtn.frame = CGRectMake(0, 0, 40, 40);
    self.commentBtn.frame = CGRectMake(40, 0, 40, 40);
    self.shareBtn.frame = CGRectMake(80, 0, 40, 40);
    self.browseLabel.frame = CGRectMake(self.momentActionView.width - 100, 0, 100, 40);
}

- (void)setListModel:(YR_ArtCircleListModel *)listModel {
    
    _listModel = listModel;
    self.nameLabel.text = listModel.user.uname;
    self.descLabel.text = listModel.content;
    NSString *uidStr = self.listModel.user.uid;
    NSString *versionStr = self.listModel.user.version;
    NSString *iconStr = [[[@"http://head.artand.cn" stringByAppendingPathComponent:uidStr] stringByAppendingPathComponent:versionStr] stringByAppendingPathComponent:@"180"];
    NSString *timeStr = self.listModel.mtime;
    NSString *newStr = [timeStr updateTimeForTimeIntervalString:timeStr];
    self.timeLabel.text = newStr;
    
    self.browseLabel.text = [NSString stringWithFormat:@"浏览%@次", self.listModel.num_view];
    
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
    [self.imageCollectionView reloadData];

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.listModel.pics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_ArtCircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    NSString *str = [NSString stringWithFormat:@"http://img1.artand.cn%@!app.n846.webp", self.listModel.pics[indexPath.row].k];
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:str]];
    return cell;
}




@end
