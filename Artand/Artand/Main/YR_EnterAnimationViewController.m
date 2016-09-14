//
//  YR_EnterAnimationViewController.m
//  Artand
//
//  Created by Dendi on 9/11/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_EnterAnimationViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "YR_GuideViewController.h"
#import "YR_BaseNavigationController.h"
#import "YR_MainViewController.h"

@interface YR_EnterAnimationViewController ()

@end

@implementation YR_EnterAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:imageView];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://ios1.artand.cn/public/bootstrap" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"url"]]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guanggaoceng6"]];
    backImageView.frame = self.view.frame;
    [self.view addSubview:backImageView];
    
    [UIView animateWithDuration:3 animations:^{
        imageView.transform = CGAffineTransformMakeScale(1.4, 1.4);
        backImageView.alpha = 0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
//            [UIApplication sharedApplication].keyWindow.rootViewController = [[YR_BaseNavigationController alloc] initWithRootViewController:[YR_GuideViewController new]];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            NSString *currentVerisonId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            
            //安装后第一次启动引导页
            
            if ([userDefaults boolForKey:currentVerisonId]) {
                
                [UIApplication sharedApplication].keyWindow.rootViewController = [[YR_MainViewController alloc] init];
            }else{
                
                [UIApplication sharedApplication].keyWindow.rootViewController = [[YR_BaseNavigationController alloc] initWithRootViewController:[YR_GuideViewController new]];
                
                [userDefaults setBool:YES forKey:currentVerisonId];
                
                [userDefaults synchronize];
                
            }
            
        }];
        
    }];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
