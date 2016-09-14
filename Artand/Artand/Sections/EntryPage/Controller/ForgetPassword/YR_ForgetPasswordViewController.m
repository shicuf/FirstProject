//
//  YR_ForgetPasswordViewController.m
//  Artand
//
//  Created by dllo on 16/8/27.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ForgetPasswordViewController.h"
#import "YR_Button.h"
#import "AFNetworking.h"
#import "YR_ForgetPasswordInputCaptchaViewController.h"
#import "YR_Macro.h"

@interface YR_ForgetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *forgetPasswordPhoneTextField;
@property (weak, nonatomic) IBOutlet YR_Button *confirmBtn;

@end

@implementation YR_ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.confirmBtn.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.forgetPasswordPhoneTextField];
}

- (void)change:(NSNotification *)notification {
    
    if (self.forgetPasswordPhoneTextField.text.length > 0) {
        self.confirmBtn.enabled = YES;
        self.confirmBtn.backgroundColor  = [UIColor blackColor];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.confirmBtn.enabled = NO;
        self.confirmBtn.backgroundColor = [UIColor clearColor];
        [self.confirmBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

#pragma mark - 点击返回按钮
- (IBAction)popLoginAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击确定按钮
- (IBAction)confirmAction:(id)sender {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *para = @{@"email":self.forgetPasswordPhoneTextField.text};
    [manager POST:@"http://v1.artand.cn/forgot_password/doForgot" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 1000) {
            // 这时候在push到发送验证码那一页
            YR_ForgetPasswordInputCaptchaViewController *captchaVC = [[YR_ForgetPasswordInputCaptchaViewController alloc] init];
            captchaVC.phoneNum = self.forgetPasswordPhoneTextField.text;
            [self.navigationController pushViewController:captchaVC animated:YES];
        } else {
            YRLog(@"%@", responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
