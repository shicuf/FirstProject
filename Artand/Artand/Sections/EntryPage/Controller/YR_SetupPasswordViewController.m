//
//  YR_SetupPasswordViewController.m
//  Artand
//
//  Created by Dendi on 8/28/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_SetupPasswordViewController.h"
#import "YR_Button.h"

@interface YR_SetupPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *setupPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet YR_Button *doneBtn;

@property (nonatomic, copy) NSString *confirmStr;

@end

@implementation YR_SetupPasswordViewController

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
    
    if ([self.setupPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        self.confirmStr = self.setupPasswordTextField.text;
        self.setupPasswordTextField.text = self.phoneStr;
        self.confirmPasswordTextField.text = self.captchaStr;
        NSLog(@"success");
    } else {
        
        NSLog(@"not match");
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
