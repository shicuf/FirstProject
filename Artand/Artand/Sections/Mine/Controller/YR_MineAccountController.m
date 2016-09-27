//
//  YR_MineAccountController.m
//  Artand
//
//  Created by Dendi on 9/16/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_MineAccountController.h"
#import "YR_Macro.h"
#import "AFNetworking.h"
#import "YR_AccountModel.h"
#import "YR_AccountTableViewCell.h"
#import "YR_AccountBirthdayModel.h"
#import "YR_AccountSyncModel.h"
#import "YR_AccountUserModel.h"

@interface YR_MineAccountController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *accountTableView;
@property (nonatomic, strong) YR_AccountModel *accountModel;

@end

@implementation YR_MineAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self handleData];
    [self setupUI];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"http://v1.artand.cn/setting/index";
    NSDictionary *para = @{@"session_id":SESSION_ID};
    [manager POST:urlStr parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.accountModel = [YR_AccountModel modelWithDict:responseObject];
        [self.accountTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupUI {
    
    self.accountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVI_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_HEIGHT) style:UITableViewStyleGrouped];
    self.accountTableView.delegate = self;
    self.accountTableView.dataSource = self;
    [self.accountTableView registerNib:[UINib nibWithNibName:@"YR_AccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    self.accountTableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    [self.view addSubview:self.accountTableView];
    
    self.titleLabel.text = @"个人资料";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 7;
    } else if (section == 2) {
        return 1;
    }
    return 3;
}

// 个性域名 性别 生日 城市 收货地址    绑定手机  登录账号  账号类型
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YR_AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.nameLabel.text = @"头像";
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.nameLabel.text = @"个性签名";
        cell.contentLabel.text = self.accountModel.user.desc;
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.nameLabel.text = @"真实姓名";
        cell.contentLabel.text = self.accountModel.user.uname;
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        cell.nameLabel.text = @"个性域名";
        cell.contentLabel.text = self.accountModel.user.domain;
    } else if (indexPath.section == 1 && indexPath.row == 3) {
        cell.nameLabel.text = @"性别";
        if ([self.accountModel.user.gender isEqualToString:@"m"]) {
            cell.contentLabel.text = @"男";
        } else {
            cell.contentLabel.text = @"女";
        }
    } else if (indexPath.section == 1 && indexPath.row == 4) {
        cell.nameLabel.text = @"生日";
        cell.contentLabel.text = [NSString stringWithFormat:@"%@-%@-%@", self.accountModel.user.birthday.year, self.accountModel.user.birthday.month, self.accountModel.user.birthday.day];
    } else if (indexPath.section == 1 && indexPath.row == 5) {
        cell.nameLabel.text = @"城市";
        cell.contentLabel.text = self.accountModel.user.city;
    } else if (indexPath.section == 1 && indexPath.row == 6) {
        cell.nameLabel.text = @"收货地址";
        cell.contentLabel.text = self.accountModel.user.address;
    } else if (indexPath.section == 2) {
        cell.nameLabel.text = @"绑定手机";
        cell.contentLabel.text = self.accountModel.user.mobile;
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        cell.nameLabel.text = @"登录账号";
        cell.contentLabel.text = self.accountModel.user.account;
    } else if (indexPath.section == 3 && indexPath.row == 1) {
        cell.nameLabel.text = @"账号类型";
        cell.contentLabel.text = self.accountModel.user.role_name;
    } else if (indexPath.section == 3 && indexPath.row == 2) {
        cell.nameLabel.text = @"如何认证为艺术家";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //弹出系统相册
            UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
            
            //设置照片来源
            pickVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            pickVC.delegate = self;
            [self presentViewController:pickVC animated:YES completion:nil];
        }];
        UIAlertAction *photoAlbumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //弹出系统相册
            UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
            
            //设置照片来源
            pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            pickVC.delegate = self;
            [self presentViewController:pickVC animated:YES completion:nil];
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [alertVC addAction:takePhotoAction];
        [alertVC addAction:photoAlbumAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 80;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}



@end
