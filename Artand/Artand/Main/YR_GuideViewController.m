//
//  YR_GuideViewController.m
//  Artand
//
//  Created by Dendi on 9/11/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_GuideViewController.h"
#import "UIView+Frame.h"
#import "YR_Macro.h"
#import "YR_MainViewController.h"
#import "YR_LogupViewController.h"

@interface YR_GuideViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation YR_GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
}

- (void)setupScrollView {
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(4 * SCREEN_WIDTH, 0);
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    CGFloat imageWidth = SCREEN_WIDTH - 20;
    CGFloat imageHeight = imageWidth * 0.44;
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * SCREEN_WIDTH, self.view.frame.size.height * 0.3, imageWidth, imageHeight)];
        NSString *imageName = [NSString stringWithFormat:@"guidePage%d", i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
        
        if (i == 3) {
            UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            goBtn.frame = CGRectMake(0, 0, 60, 60);
            goBtn.center = CGPointMake(3.5 * SCREEN_WIDTH, SCREEN_HEIGHT * 0.75);
            [goBtn setImage:[UIImage imageNamed:@"gotoRegister"] forState:UIControlStateNormal];
            [goBtn setImage:[UIImage imageNamed:@"gotoRegisterhighlight"] forState:UIControlStateHighlighted];
            [goBtn addTarget:self action:@selector(jumpTimelineView:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:goBtn];
        }
    }
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 30, SCREEN_WIDTH, 20)];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pageControl];
}

- (void)jumpTimelineView:(UIButton *)btn {

    [self createPublicTimelineView];
}

- (void)createPublicTimelineView {
    
    UIView *publicTimelineView = [[UIView alloc] initWithFrame:self.view.frame];
    publicTimelineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:publicTimelineView];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guidePage5"]];
    backImageView.frame = publicTimelineView.frame;
    [publicTimelineView addSubview:backImageView];
    
    [UIView animateWithDuration:3 animations:^{
        backImageView.transform = CGAffineTransformMakeScale(1.25, 1.25);
    }];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLogo"]];
    CGFloat logoWidth = SCREEN_WIDTH - 128;
    CGFloat logoScale = 154.0 / 418.0;
    CGFloat logoHeight = logoWidth * logoScale;
    logoImageView.frame = CGRectMake(0, 0, logoWidth, logoHeight);
    logoImageView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT * 0.4);
    [publicTimelineView addSubview:logoImageView];
    
    UIButton *logupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logupBtn.frame = CGRectMake(10, SCREEN_HEIGHT - 50, SCREEN_WIDTH - 20, 40);
    [logupBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [logupBtn setBackgroundColor:[UIColor whiteColor]];
    logupBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [logupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logupBtn addTarget:self action:@selector(jumpLogupViewController:) forControlEvents:UIControlEventTouchUpInside];
    [publicTimelineView addSubview:logupBtn];
    
    UIButton *timeLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeLineBtn.frame = CGRectMake(10, CGRectGetMinY(logupBtn.frame) - 50, logupBtn.width, logupBtn.height);
    [timeLineBtn setTitle:@"随便看看" forState:UIControlStateNormal];
    [timeLineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    timeLineBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    timeLineBtn.layer.borderWidth = 1;
    timeLineBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    timeLineBtn.backgroundColor = [UIColor clearColor];
    [timeLineBtn addTarget:self action:@selector(jumpMainViewController:) forControlEvents:UIControlEventTouchUpInside];
    [publicTimelineView addSubview:timeLineBtn];
}

- (void)jumpLogupViewController:(UIButton *)btn {
    
    YR_LogupViewController *logupVC = [YR_LogupViewController new];
    [self.navigationController pushViewController:logupVC animated:YES];
}

- (void)jumpMainViewController:(UIButton *)btn {
    
    [UIView animateWithDuration:1 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [YR_MainViewController new];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.pageControl setCurrentPage:scrollView.contentOffset.x / SCREEN_WIDTH];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
