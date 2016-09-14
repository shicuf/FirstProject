//
//  YR_NotificationViewController.m
//  Artand
//
//  Created by dllo on 16/8/27.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_NotificationViewController.h"
#import "YR_Macro.h"

@interface YR_NotificationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contactTableView;

@end

@implementation YR_NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}



- (void)setupUI {
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVI_HEIGHT)];
    naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:naviView];
    
    UILabel *privateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, NAVI_HEIGHT - STATUSBAR_HEIGHT)];
    privateTitleLabel.text = @"私信";
    privateTitleLabel.textColor = [UIColor blackColor];
    privateTitleLabel.font = [UIFont systemFontOfSize:18];
    privateTitleLabel.textAlignment = NSTextAlignmentCenter;
    [naviView addSubview:privateTitleLabel];
    
    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    separateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [naviView addSubview:separateLine];
    
//    gba(0.34, 0.68, 0.41, 1)
    UIButton *writePrivateLetterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat margin = 15;
    CGFloat btnWidth = 55;
    writePrivateLetterBtn.frame = CGRectMake(SCREEN_WIDTH - margin - btnWidth, 20, btnWidth, NAVI_HEIGHT - STATUSBAR_HEIGHT);
    [writePrivateLetterBtn setTitle:@"写私信" forState:UIControlStateNormal];
    [writePrivateLetterBtn setTitleColor:[UIColor colorWithRed:0.34 green:0.68 blue:0.41 alpha:1.0] forState:UIControlStateNormal];
    writePrivateLetterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [naviView addSubview:writePrivateLetterBtn];
    
    self.contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVI_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_HEIGHT - TAB_HEIGHT) style:UITableViewStylePlain];
    self.contactTableView.delegate = self;
    self.contactTableView.dataSource = self;
    [self.view addSubview:self.contactTableView];
    [self.contactTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.textLabel.text = @"test";
    return cell;
}

@end
