//
//  YR_LogupViewController.m
//  Artand
//
//  Created by Dendi on 8/28/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_LogupViewController.h"
#import "AFNetworking.h"
#import "YR_SetupPasswordViewController.h"
#import "YR_Button.h"

@interface YR_LogupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *logupPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *logupCaptchaTextField;
@property (weak, nonatomic) IBOutlet YR_Button *nextStepBtn;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation YR_LogupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.logupPhoneTextField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.logupCaptchaTextField];
}

- (void)change:(NSNotification *)notification {
    
    if (_logupPhoneTextField.text.length > 0 && _logupCaptchaTextField.text.length > 0) {
        self.nextStepBtn.enabled = YES;
        self.nextStepBtn.backgroundColor = [UIColor blackColor];
        [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.nextStepBtn.enabled = NO;
        self.nextStepBtn.backgroundColor = [UIColor clearColor];
        [self.nextStepBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

#pragma mark - 点击获取验证码按钮
- (IBAction)getCaptchaAction:(id)sender {
    
    self.manager = [AFHTTPSessionManager manager];
    NSDictionary *para = @{@"area":@"86",
                           @"mobile":self.logupPhoneTextField.text,
                           @"type":@"sign"};
    
    [_manager POST:@"http://ios1.artand.cn/signup/sms" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - 点击下一步按钮
- (IBAction)nextStepAction:(id)sender {
    
    NSDictionary *para = @{@"email":self.logupPhoneTextField.text,
                           @"verify":self.logupCaptchaTextField.text};
    self.manager =  [AFHTTPSessionManager manager];
    [_manager POST:@"http://ios1.artand.cn/signup/checkVerify" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    YR_SetupPasswordViewController *setupPasswordVC = [[YR_SetupPasswordViewController alloc] init];
    setupPasswordVC.captchaStr = self.logupCaptchaTextField.text;
    setupPasswordVC.phoneStr = self.logupPhoneTextField.text;
    [self.navigationController pushViewController:setupPasswordVC animated:YES];
}
#pragma mark - 点击返回和登录按钮
- (IBAction)popLoginAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.logupPhoneTextField];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.logupCaptchaTextField];
}

@end
