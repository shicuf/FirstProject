//
//  YR_ArticleWebViewController.m
//  Artand
//
//  Created by Dendi on 9/5/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_ArticleWebViewController.h"
#import "YR_Macro.h"
#import "AFNetworking.h"
#import "YR_ArticleDetailModel.h"
#import "YR_ArticleDetailArticleModel.h"

@interface YR_ArticleWebViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView *tabBarView;

@property (nonatomic, strong) YR_ArticleDetailModel *articleDetailModel;

@end

@implementation YR_ArticleWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIAtIndex:0];
    [self handleDataWithIndex:0];
}

- (void)handleDataWithIndex:(NSInteger)index {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *rowStr = [NSString stringWithFormat:@"http://ios1.artand.cn/article/siblings?artid=%@", self.row_id];
    [manager POST:rowStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"list"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * arr.count, 0);
        });
        NSString *urlStr = [NSString stringWithFormat:@"http://v1.artand.cn/article/index2/%@", arr[index]];
        [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.articleDetailModel = [YR_ArticleDetailModel modelWithDict:responseObject];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.webView loadHTMLString:[NSString stringWithFormat:@"%@%@", self.articleDetailModel.article.content1, self.articleDetailModel.article.content] baseURL:nil];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupUIAtIndex:(NSInteger)index {
    
    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.pagingEnabled = YES;
    self.backScrollView.delegate = self;
    [self.view addSubview:self.backScrollView];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backView.backgroundColor = [UIColor redColor];
    [self.backScrollView addSubview:self.backView];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49)];
    [self.backView addSubview:self.webView];
    self.webView.delegate = self;
    
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(index * SCREEN_WIDTH, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    self.tabBarView.backgroundColor = [UIColor orangeColor];
    [self.backView addSubview:self.tabBarView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self setupUIAtIndex:index];
    [self handleDataWithIndex:index];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *jsString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"article" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    [_webView stringByEvaluatingJavaScriptFromString:jsString];
}


@end
