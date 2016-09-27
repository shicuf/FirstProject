//
//  YR_NotificationContactController.m
//  Artand
//
//  Created by Dendi on 9/16/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_NotificationContactController.h"
#import "YR_Macro.h"

@interface YR_NotificationContactController ()

@end

@implementation YR_NotificationContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVI_HEIGHT)];
    naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:naviView];
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.frame = CGRectMake(0, 20, 44, 44);
    [popBtn setImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
    [naviView addSubview:popBtn];
    [popBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *searchContactLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, NAVI_HEIGHT - STATUSBAR_HEIGHT)];
    searchContactLabel.text = @"查找联系人";
    searchContactLabel.textColor = [UIColor blackColor];
    searchContactLabel.font = [UIFont systemFontOfSize:18];
    searchContactLabel.textAlignment = NSTextAlignmentCenter;
    [naviView addSubview:searchContactLabel];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [naviView addSubview:separateLine];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, NAVI_HEIGHT + 2, SCREEN_WIDTH - 30, 30)];
    searchBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchBar];
}


- (void)popAction:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
