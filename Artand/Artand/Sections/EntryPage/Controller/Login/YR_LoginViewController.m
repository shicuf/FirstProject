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
#import "YR_Macro.h"
#import "YR_LoginModel.h"
#import "YR_AlertViewTool.h"
#import "YR_LoginImModel.h"
#import "YR_LoginUserModel.h"
#import "MozTopAlertView.h"
#import "SVProgressHUD.h"
#import "NSString+YR_RegEx.h"

@interface YR_LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextField;
@property (weak, nonatomic) IBOutlet YR_Button *loginBtn;
@property (nonatomic, strong) YR_LoginModel *loginModel;

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
    
    [self.view endEditing:YES];
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
    
    if ([NSString isMobileNumber:self.loginPhoneTextField.text]) {
        [SVProgressHUD show];
        NSDictionary *para = @{@"email":self.loginPhoneTextField.text,
                               @"password":self.loginPasswordTextField.text};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:@"http://ios1.artand.cn/login/doLogin" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.loginModel = [YR_LoginModel modelWithDict:responseObject];
            if ([self.loginModel.code isEqual:@1000]) {
                [SVProgressHUD dismiss];
                [[NSUserDefaults standardUserDefaults] setObject:self.loginModel.session_id forKey:@"session_id"];
                [[NSUserDefaults standardUserDefaults] setObject:self.loginModel.user.uid forKey:@"uid"];
                [[NSUserDefaults standardUserDefaults] setObject:self.loginModel.user.uname forKey:@"uname"];
                [[NSUserDefaults standardUserDefaults] setObject:self.loginModel.user.version forKey:@"version"];
                [[NSUserDefaults standardUserDefaults] setObject:self.loginModel.user.thead forKey:@"thead"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [MozTopAlertView showWithType:MozAlertTypeSuccess text:@"登录成功" parentView:self.navigationController.view];
                [self.loginPasswordTextField resignFirstResponder];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            } else {
                [SVProgressHUD dismiss];
                //            [YR_AlertViewTool toolWithAlertTitle:@"Artand" message:responseObject[@"msg"] controller:self];
                [MozTopAlertView showWithType:MozAlertTypeError text:responseObject[@"msg"] parentView:self.navigationController.view];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];

    } else {
        [MozTopAlertView showWithType:MozAlertTypeError text:@"请输入正确的手机号" parentView:self.view];
    }
}
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.loginPhoneTextField];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.loginPasswordTextField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (IBAction)quickLogin:(id)sender {
    
    MozTopAlertView *alerView = [MozTopAlertView showWithType:MozAlertTypeWarning text:@"该功能暂未开放" parentView:self.view];
    alerView.duration = 1;
}



@end
