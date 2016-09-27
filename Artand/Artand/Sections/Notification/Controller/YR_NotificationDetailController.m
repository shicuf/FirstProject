//
//  YR_NotificationDetailController.m
//  Artand
//
//  Created by Dendi on 9/16/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_NotificationDetailController.h"
#import "YR_Macro.h"

@interface YR_NotificationDetailController ()

@end

@implementation YR_NotificationDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVI_HEIGHT)];
    naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:naviView];
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.frame = CGRectMake(0, 20, 44, 44);
    [popBtn setImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
    [naviView addSubview:popBtn];
    [popBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 44, 20, 44, 44);
    [deleteBtn setImage:[UIImage imageNamed:@"deletenotice"] forState:UIControlStateNormal];
    [naviView addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *notiTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, NAVI_HEIGHT - STATUSBAR_HEIGHT)];
    notiTitleLabel.text = @"通知";
    notiTitleLabel.textColor = [UIColor blackColor];
    notiTitleLabel.font = [UIFont systemFontOfSize:18];
    notiTitleLabel.textAlignment = NSTextAlignmentCenter;
    [naviView addSubview:notiTitleLabel];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [naviView addSubview:separateLine];
    
    UIView *noNotiView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVI_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_HEIGHT)];
    noNotiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:noNotiView];
    
    UIImageView *notiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    notiImageView.image = [UIImage imageNamed:@"empty_msg"];
    notiImageView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT * 0.3);
    [noNotiView addSubview:notiImageView];
    
    UILabel *notiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(notiImageView.frame) + 10, SCREEN_WIDTH, 20)];
    notiLabel.text = @"你还没有通知消息";
    notiLabel.textColor = [UIColor lightGrayColor];
    notiLabel.textAlignment = NSTextAlignmentCenter;
    notiLabel.font = [UIFont systemFontOfSize:13];
    [noNotiView addSubview:notiLabel];
    
}

- (void)popAction:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteAction:(UIButton *)btn {
    
    YRLog(@"删除通知");
}



@end
