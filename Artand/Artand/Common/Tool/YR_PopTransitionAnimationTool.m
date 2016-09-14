//
//  YR_PopTransitionAnimationTool.m
//  Artand
//
//  Created by dllo on 2016/9/12.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_PopTransitionAnimationTool.h"
#import "YR_ArtDetailViewController.h"
#import "YR_ArtDetailImageTransitionController.h"

@implementation YR_PopTransitionAnimationTool

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    YR_ArtDetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    YR_ArtDetailImageTransitionController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    toVC.fromImageView.hidden = YES;
    // 截图大法
    UIView *snapView = [fromVC.toImageView snapshotViewAfterScreenUpdates:NO];
    [containerView addSubview:snapView];
    snapView.frame = fromVC.toImageView.frame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
//        snapView.frame = toVC.fromImageView.frame;
        snapView.frame = CGRectMake(toVC.fromImageView.frame.origin.x, toVC.fromImageView.frame.origin.y + 64, toVC.fromImageView.frame.size.width, toVC.fromImageView.frame.size.height);
    } completion:^(BOOL finished) {
        toVC.fromImageView.hidden = NO;
        [snapView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

@end
