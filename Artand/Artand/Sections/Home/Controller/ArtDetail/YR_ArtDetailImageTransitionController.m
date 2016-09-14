//
//  YR_ArtDetailImageTransitionController.m
//  Artand
//
//  Created by Dendi on 9/11/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailImageTransitionController.h"
#import "UIView+Frame.h"
#import "YR_BaseNavigationController.h"

@interface YR_ArtDetailImageTransitionController ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) YR_BaseNavigationController *nav;

@end

@implementation YR_ArtDetailImageTransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backImageView.image = [UIImage imageNamed:@"preview5"];
    [self.view addSubview:self.backImageView];
    
    self.toImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.toImageView.width = self.imageWidth / 5;
    self.toImageView.height = self.imageHeight / 5;
    self.toImageView.center = self.view.center;
    self.toImageView.image = self.image;
    [self.view addSubview:self.toImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pop:)];
    [self.view addGestureRecognizer:tap];
    
    // 获取到导航控制器的全局返回手势禁用, 要不就崩了
    self.nav = (YR_BaseNavigationController *)self.navigationController;
    self.nav.pan.enabled = NO;
}

- (void)pop:(UITapGestureRecognizer *)tap {
    
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.delegate = nil;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    // 视图将要消失的时候恢复全局的返回手势
    self.nav.pan.enabled = YES;
}


@end
