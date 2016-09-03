//
//  YR_BaseNavigationController.m
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_BaseNavigationController.h"

@interface YR_BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation YR_BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;
    
    // 获得系统调用代理
    id target = self.interactivePopGestureRecognizer.delegate;
    // 自定义全屏手势 NSSelectorFromString() 这个方法略屌
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    // 设置代理
    pan.delegate = self;
    // 关闭系统手势
    self.interactivePopGestureRecognizer.enabled = NO;
    // 添加手势
    [self.view addGestureRecognizer:pan];
}
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势
        return NO;
    }
    return YES;
}


@end
