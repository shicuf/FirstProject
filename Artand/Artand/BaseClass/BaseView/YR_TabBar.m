//
//  YR_TabBar.m
//  Artand
//
//  Created by Dendi on 8/31/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_TabBar.h"

@implementation YR_TabBar

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sharebar"]];
        [self setBackgroundImage:[UIImage imageNamed:@"sharebar"]];
        self.shadowImage = [UIImage new];
//        self.tintColor = [UIColor colorWithRed:254.0/255.0 green:59.0/255.0 blue:108.0/255.0 alpha:255.0/255.0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self searchTabBarButton];
}

- (void)searchTabBarButton {
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick2:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    for (UIView *subView in tabBarButton.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]
            || [subView isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
            //需要实现的帧动画,这里根据需求自定义
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.5,@0.9,@1.15,@0.95,@1.02,@1.0];
            animation.duration = 0.5;
            animation.calculationMode = kCAAnimationCubic;
            //把动画添加上去就OK了
            [subView.layer addAnimation:animation forKey:nil];
        }
    }
}

- (void)tabBarButtonClick2:(UIControl *)tabBarButton {
    //需要实现的帧动画,这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    //把动画添加上去就OK了
    [tabBarButton.layer addAnimation:animation forKey:nil];
}

@end
