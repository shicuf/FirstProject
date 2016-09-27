//
//  YR_MineSettingController.m
//  Artand
//
//  Created by Dendi on 9/16/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_MineSettingController.h"
#import "YR_Macro.h"
#import "YR_MineAccountController.h"
#import "YR_MainViewController.h"
#import "YR_HomeViewController.h"
#import "MozTopAlertView.h"
#import "YR_AccountTableViewCell.h"
#import "YR_ClearCachesTool.h"

@interface YR_MineSettingController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTableView;

@end

@implementation YR_MineSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVI_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_HEIGHT) style:UITableViewStyleGrouped];
    self.settingTableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    [self.settingTableView registerNib:[UINib nibWithNibName:@"YR_AccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [self.view addSubview:self.settingTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"个人资料";
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"密码管理";
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"隐私";
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = @"通知";
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        cell.nameLabel.text = @"清理存储空间";
        CGFloat cacheSize = [YR_ClearCachesTool folderSizeAtPath];
        cell.contentLabel.text = [NSString stringWithFormat:@"%.2fM", cacheSize];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"多语言";
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        cell.textLabel.text = @"去评分";
    } else if (indexPath.section == 3 && indexPath.row == 1) {
        cell.textLabel.text = @"支持和帮助";
    } else if (indexPath.section == 3 && indexPath.row == 2) {
        cell.textLabel.text = @"意见反馈";
    } else {
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        YR_MineAccountController *accountVC = [YR_MineAccountController new];
        [self.navigationController pushViewController:accountVC animated:YES];
    } else if (indexPath.section == 4) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"下次登录依然可以使用本账号" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *quitAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"session_id"];
            YR_MainViewController *main = (YR_MainViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            [self.navigationController popToRootViewControllerAnimated:NO];
            [main setSelectedIndex:0];
            [MozTopAlertView showWithType:MozAlertTypeSuccess text:@"退出成功" parentView:[UIApplication sharedApplication].keyWindow];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:quitAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        [YR_ClearCachesTool cleanCache:^{
            
            [MozTopAlertView showWithType:MozAlertTypeSuccess text:@"清理成功" parentView:self.view];
            [self.settingTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10;
    }
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 5;
}


@end
