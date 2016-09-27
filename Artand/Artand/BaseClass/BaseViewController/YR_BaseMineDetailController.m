//
//  YR_BaseMineDetailController.m
//  Artand
//
//  Created by Dendi on 9/16/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_BaseMineDetailController.h"
#import "YR_Macro.h"

@interface YR_BaseMineDetailController ()



@end

@implementation YR_BaseMineDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVI_HEIGHT)];
    _naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_naviView];
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.frame = CGRectMake(0, 20, 44, 44);
    [popBtn setImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
    [popBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [_naviView addSubview:popBtn];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(SCREEN_WIDTH - 44, 20, 44, 44);
    _moreBtn.hidden = YES;
    [_moreBtn setImage:[UIImage imageNamed:@"Detailmore"] forState:UIControlStateNormal];
    [_naviView addSubview:_moreBtn];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, NAVI_HEIGHT - 0.5, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [_naviView addSubview:separateLine];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, SCREEN_WIDTH - 88, 44)];
    _titleLabel.text = self.titleStr;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor darkGrayColor];
    [_naviView addSubview:_titleLabel];
}

- (void)pop:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
