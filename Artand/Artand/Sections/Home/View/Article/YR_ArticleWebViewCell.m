//
//  YR_ArticleWebViewCell.m
//  Artand
//
//  Created by dllo on 16/9/6.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ArticleWebViewCell.h"
#import "YR_ArticleDetailModel.h"
#import "YR_ArticleDetailArticleModel.h"
#import "AFNetworking.h"
#import "YR_Macro.h"
#import "Masonry.h"

//static CGFloat const footerViewHeight = 700;

@interface YR_ArticleWebViewCell () <UIWebViewDelegate>

@property (nonatomic, assign) CGFloat webViewHeight;
@property (nonatomic ,strong) UIView *footerView;

@end

@implementation YR_ArticleWebViewCell


- (void)awakeFromNib {
    [super awakeFromNib];

    self.articleWebView.delegate = self;
    // 解决webView横向能滑动问题
    self.articleWebView.scrollView.alwaysBounceHorizontal = NO;
    
    
}

- (IBAction)moreAction:(id)sender {
    
    self.shareBlock();
}

- (IBAction)likeAction:(id)sender {
    
    
}

- (IBAction)popAction:(id)sender {
    
    // 调用block
    self.popBlock();
}

- (IBAction)commentAction:(id)sender {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *jsString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"article" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    [self.articleWebView stringByEvaluatingJavaScriptFromString:jsString];
#warning 计算webView的内容高度 通过返回webView的内容高度来确定footerView的位置
    self.webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    
//    if (self.webViewHeight != 0) {
//        self.articleWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, footerViewHeight, 0);
//        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.webViewHeight, SCREEN_WIDTH, footerViewHeight)];
//        [self setupFooterView];
//        self.footerView.backgroundColor = [UIColor greenColor];
//        NSLog(@"%f", self.webViewHeight);
//        [self.articleWebView.scrollView addSubview:self.footerView];
//    }
}

- (void)setupFooterView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.footerView addSubview:view];
    view.backgroundColor = [UIColor blueColor];
}

// 在重用池重新加载新的cell的时候将上一次cell中的内容清空, 重新加载
- (void)prepareForReuse {
    
    [super prepareForReuse];
    [self.articleWebView loadHTMLString:@"" baseURL:nil];
}


- (void)setArticleDetailModel:(YR_ArticleDetailModel *)articleDetailModel {
    
    _articleDetailModel = articleDetailModel;
    [_articleWebView loadHTMLString:[NSString stringWithFormat:@"%@%@", articleDetailModel.article.content1, articleDetailModel.article.content] baseURL:nil];
}



@end
