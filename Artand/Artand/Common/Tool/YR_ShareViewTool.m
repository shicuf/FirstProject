//
//  YR_ShareViewTool.m
//  Artand
//
//  Created by dllo on 2016/9/13.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ShareViewTool.h"
#import "YR_Macro.h"
#import "YR_BaseNavigationController.h"
#import "UIView+Frame.h"

@interface YR_ShareViewTool ()

@property (nonatomic, strong) YR_BaseNavigationController *nav;

@end

@implementation YR_ShareViewTool

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionFade;
    
    for (YR_BaseNavigationController *nav in [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers) {
        [nav.view.layer addAnimation:transition forKey:nil];
    }
    
    self.nav = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
    [self.nav.view.layer addAnimation:transition forKey:nil];
    self.nav.pan.enabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView:)];
    [self addGestureRecognizer:tap];
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 300)];
    shareView.backgroundColor = [UIColor whiteColor];
    [self addSubview:shareView];
    
    UIScrollView *upScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 123)];
    [shareView addSubview:upScrollView];
    upScrollView.showsHorizontalScrollIndicator = NO;
    upScrollView.contentSize = CGSizeMake(375, 0);
    UIScrollView *downScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 123, SCREEN_WIDTH, 123)];
    [shareView addSubview:downScrollView];
    downScrollView.contentSize = CGSizeMake(375, 0);
    downScrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat margin = 31;
    CGFloat y = 22;
    CGFloat btnWidth = 55;
    NSArray *btnArr = @[@"shareartand", @"sharewebchat", @"sharewebchat01", @"shareweibo"];
    NSArray *highlightedBtnArr = @[@"shareartand_an", @"sharewebchat_en", @"sharewebchat01_an", @"shareweibo_an"];
    NSArray *upTitleArr = @[@"好友", @"微信好友", @"朋友圈", @"新浪微博"];
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(margin + i * (btnWidth + margin), y, btnWidth, btnWidth);
        [btn setImage:[UIImage imageNamed:btnArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:highlightedBtnArr[i]] forState:UIControlStateHighlighted];
        [upScrollView addSubview:btn];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 65, 20)];
        label.centerX = btn.centerX;
        label.text = upTitleArr[i];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [upScrollView addSubview:label];
    }
    UIView *firSeparateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 122.5, SCREEN_WIDTH, 0.5)];
    firSeparateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [upScrollView addSubview:firSeparateLine];
    
    NSArray *shareBtnArr = @[@"share_url", @"share_safari", @"share_jubao"];
    NSArray *shareHighlightedBtnArr = @[@"share_url_en_", @"share_safari_en", @"share_jubao_en"];
    NSArray *downTitleArr = @[@"复制链接", @"用Safari打开", @"举报"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(margin + i * (btnWidth + margin), y, btnWidth, btnWidth);
        [btn setImage:[UIImage imageNamed:shareBtnArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:shareHighlightedBtnArr[i]] forState:UIControlStateHighlighted];
        [downScrollView addSubview:btn];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 65, 20)];
        label.centerX = btn.centerX;
        label.text = downTitleArr[i];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [downScrollView addSubview:label];
    }
    UIView *secSeparateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 122.5, SCREEN_WIDTH, 0.5)];
    secSeparateLine.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [downScrollView addSubview:secSeparateLine];
    
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(downScrollView.frame), SCREEN_WIDTH, 56)];
    cancelLabel.text = @"取消";
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.textColor = [UIColor blackColor];
    cancelLabel.font = [UIFont systemFontOfSize:16];
    [shareView addSubview:cancelLabel];
}

- (void)cancelView:(UITapGestureRecognizer *)tap {
    
    [self removeFromSuperview];
    self.nav.pan.enabled = YES;
}


@end
