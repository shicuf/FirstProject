//
//  YR_ForgetPasswordInputCaptchaViewController.m
//  Artand
//
//  Created by dllo on 16/9/3.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ForgetPasswordInputCaptchaViewController.h"
#import "YR_Button.h"
#import "AFNetworking.h"
#import "YR_ForgetPasswordResetViewController.h"
#import "MozTopAlertView.h"

@interface YR_ForgetPasswordInputCaptchaViewController ()

@property (weak, nonatomic) IBOutlet UITextField *captchaTextField;
@property (weak, nonatomic) IBOutlet YR_Button *confirmBtn;

@end

@implementation YR_ForgetPasswordInputCaptchaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.captchaTextField];
}

- (void)change:(NSNotification *)notification {
    
    if (self.captchaTextField.text.length > 0) {
        self.confirmBtn.enabled = YES;
        self.confirmBtn.backgroundColor  = [UIColor blackColor];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.confirmBtn.enabled = NO;
        self.confirmBtn.backgroundColor = [UIColor clearColor];
        [self.confirmBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}


- (IBAction)inputCaptchaAction:(id)sender {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *para = @{@"email":self.phoneNum, @"num":self.captchaTextField.text};
    [manager POST:@"http://v1.artand.cn/forgot_password/check_num" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject[@"code"] integerValue] == 1000) {
            YR_ForgetPasswordResetViewController *vc = [[YR_ForgetPasswordResetViewController alloc] init];
            vc.num = self.captchaTextField.text;
            vc.email = self.phoneNum;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [MozTopAlertView showWithType:MozAlertTypeError text:responseObject[@"msg"] parentView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.captchaTextField];
}

@end
