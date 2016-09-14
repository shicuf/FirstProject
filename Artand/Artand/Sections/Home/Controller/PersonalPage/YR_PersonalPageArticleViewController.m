//
//  YR_PersonalPageArticleViewController.m
//  Artand
//
//  Created by dllo on 16/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PersonalPageArticleViewController.h"
#import "YR_Macro.h"
#import "AFNetworking.h"

@interface YR_PersonalPageArticleViewController ()

@end

@implementation YR_PersonalPageArticleViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self handleData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // http://v1.artand.cn/user/24967/article
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_article"]];
    imageView.frame = CGRectMake(0, 0, 100, 100);
    imageView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT * 0.2);
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, SCREEN_WIDTH, 20)];
    label.text = @"这家伙很懒, 还没有发布文章";
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
}

- (void)handleData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://v1.artand.cn/user/%@/article", self.uid];
    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


@end
