//
//  YR_LoginViewController.m
//  Artand
//
//  Created by dllo on 16/8/27.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_LoginViewController.h"
#import "YR_ForgetPasswordViewController.h"
#import "YR_LogupViewController.h"
#import "AFNetworking.h"
#import "YR_Button.h"

@interface YR_LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextField;
@property (weak, nonatomic) IBOutlet YR_Button *loginBtn;

@end

@implementation YR_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 按钮默认状态是disabled
    self.loginBtn.enabled = NO;
    self.loginPhoneTextField.delegate = self;
    self.loginPasswordTextField.delegate = self;
    // 通知中心添加观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.loginPhoneTextField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.loginPasswordTextField];
}
// 判断按钮状态
- (void)change:(NSNotification *)notification {
    
    if (_loginPhoneTextField.text.length > 0 && _loginPasswordTextField.text.length > 0) {
        self.loginBtn.enabled = YES;
        self.loginBtn.backgroundColor = [UIColor blackColor];
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.loginBtn.enabled = NO;
        self.loginBtn.backgroundColor = [UIColor clearColor];
        [self.loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

#pragma mark - 点击关闭按钮
- (IBAction)dismissController:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 点击注册按钮
- (IBAction)logup:(id)sender {
    
    YR_LogupViewController *logoutVC = [[YR_LogupViewController alloc] init];
    [self.navigationController pushViewController:logoutVC animated:YES];
}
#pragma mark - 点击忘记密码按钮
- (IBAction)forgetPassword:(id)sender {
    
    YR_ForgetPasswordViewController *forgetpwdVC = [[YR_ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetpwdVC animated:YES];
}
#pragma mark - 点击登录按钮
- (IBAction)loginAction:(id)sender {
    
    NSDictionary *para = @{@"email":self.loginPhoneTextField.text,
                           @"password":self.loginPasswordTextField.text};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://ios1.artand.cn/login/doLogin" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] integerValue] == 1000) {
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"--------------登录成功--------------");
        } else {
            NSLog(@"登录失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.loginPhoneTextField];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.loginPasswordTextField];
}


@end
