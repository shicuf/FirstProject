//
//  YR_ForgetPasswordResetViewController.m
//  Artand
//
//  Created by dllo on 16/9/3.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ForgetPasswordResetViewController.h"
#import "YR_Button.h"
#import "AFNetworking.h"
#import "YR_Macro.h"
#import "MozTopAlertView.h"

@interface YR_ForgetPasswordResetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *setupPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet YR_Button *doneBtn;

@property (nonatomic, copy) NSString *confirmStr;


@end

@implementation YR_ForgetPasswordResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.setupPasswordTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:self.confirmPasswordTextField];
}

- (void)change:(NSNotification *)notification {
    
    if (self.setupPasswordTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0) {
        self.doneBtn.enabled = YES;
        self.doneBtn.backgroundColor = [UIColor blackColor];
        [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.doneBtn.enabled = NO;
        self.doneBtn.backgroundColor = [UIColor clearColor];
        [self.doneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
}

- (IBAction)setupDoneAction:(id)sender {
//    password	qqq111
//    num	529735
//    email	18642821945
//    session_id	(null)
    

    if ([self.setupPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        self.confirmStr = self.setupPasswordTextField.text;
        NSLog(@"success");
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSDictionary *para = @{@"password":self.setupPasswordTextField.text, @"num":self.num, @"email":self.email, @"session_id":@"(null)"};
        [manager POST:@"http://v1.artand.cn/forgot_password/doReset" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", responseObject);
            if ([responseObject[@"code"] integerValue] == 1000) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                YRLog(@"修改成功");
                [MozTopAlertView showWithType:MozAlertTypeSuccess text:@"修改成功" parentView:self.view];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
        
    } else {
        [MozTopAlertView showWithType:MozAlertTypeError text:@"两次输入密码不匹配" parentView:self.view];
        YRLog(@"not match");
    }
    
    //    NSDictionary *para = @{@"area":@"86", @"verify":self.captchaStr,
    //                           @"email":self.phoneStr,
    //                           @"password":self.confirmStr};
    
    
    //    [_manager POST:@"http://ios1.artand.cn/signup/sign" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"%@", responseObject);
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        NSLog(@"%@", error);
    //    }];
}

@end
