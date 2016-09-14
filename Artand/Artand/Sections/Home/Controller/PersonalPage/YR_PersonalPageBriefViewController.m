//
//  YR_PersonalPageBriefViewController.m
//  Artand
//
//  Created by dllo on 16/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageBriefViewController.h"
#import "AFNetworking.h"
#import "YR_Macro.h"
#import "YR_PersonalBriefModel.h"
#import "YR_PersonalBriefResumeModel.h"

@interface YR__PersonalPageBriefViewController () <UIWebViewDelegate>

@property (nonatomic, strong) YR_PersonalBriefModel *briefModel;

@end

@implementation YR__PersonalPageBriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)viewDidAppear:(BOOL)animated {
#warning 请求太多次了
    [super viewDidAppear:animated];
    [self handleData];
}

- (void)setupUI {
    
    self.briefWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 108)];
    [self.view addSubview:self.briefWebView];
    self.briefWebView.delegate = self;
    self.briefWebView.scrollView.alwaysBounceHorizontal = NO;
    [self.briefWebView reload];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://v1.artand.cn/user/%@/resume", self.uid];
    // http://v1.artand.cn/user/672/resume
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.briefModel = [YR_PersonalBriefModel modelWithDict:responseObject];
        [self.briefWebView loadHTMLString:self.briefModel.resume.resume baseURL:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YRLog(@"%@", error);
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *jsString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"article" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    [self.briefWebView stringByEvaluatingJavaScriptFromString:jsString];
}



@end
