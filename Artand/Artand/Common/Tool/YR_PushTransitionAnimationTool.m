//
//  YR_PushTransitionAnimationTool.m
//  Artand
//
//  Created by Dendi on 9/11/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_PushTransitionAnimationTool.h"
#import "YR_ArtDetailViewController.h"
#import "YR_ArtDetailImageTransitionController.h"

@implementation YR_PushTransitionAnimationTool

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    YR_ArtDetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    YR_ArtDetailImageTransitionController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    toVC.toImageView.hidden = YES;
    // 截图大法
    UIView *snapView = [fromVC.fromImageView snapshotViewAfterScreenUpdates:NO];
    [containerView addSubview:snapView];
    snapView.frame = fromVC.newRect;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
        snapView.frame = toVC.toImageView.frame;
    } completion:^(BOOL finished) {
        toVC.toImageView.hidden = NO;
        [snapView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
