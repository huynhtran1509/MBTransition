//
//  MBZoomTransition.m
//  MBTransition
//
//  Created by MmoaaY on 15/8/19.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

#import "MBZoomTransition.h"

#define kRZPushScaleChangePct 0.0

@implementation MBZoomTransition

#pragma mark - UIViewControllerContextTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    BOOL reversed = [self isReversedFromViewController:fromVC ToViewController:toVC];
    
    if (!reversed)
    {
        [container insertSubview:toVC.view belowSubview:fromVC.view];
        toVC.view.transform = CGAffineTransformMakeScale(1.0 - kRZPushScaleChangePct, 1.0 - kRZPushScaleChangePct);
        
        [toVC viewWillAppear:YES];
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             toVC.view.transform = CGAffineTransformIdentity;
                             fromVC.view.transform = CGAffineTransformMakeScale(1.0 + kRZPushScaleChangePct, 1.0 + kRZPushScaleChangePct);
                             fromVC.view.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             toVC.view.transform = CGAffineTransformIdentity;
                             fromVC.view.transform = CGAffineTransformIdentity;
                             fromVC.view.alpha = 1.0f;
                             [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         }];
    }
    else
    {
        [container addSubview:toVC.view];
        toVC.view.transform = CGAffineTransformMakeScale(1.0 + kRZPushScaleChangePct, 1.0 + kRZPushScaleChangePct);
        toVC.view.alpha = 0.0f;
        
        [toVC viewWillAppear:YES];
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             toVC.view.transform = CGAffineTransformIdentity;
                             toVC.view.alpha = 1.0f;
                             fromVC.view.transform = CGAffineTransformMakeScale(1.0 - kRZPushScaleChangePct, 1.0 - kRZPushScaleChangePct);
                         }
                         completion:^(BOOL finished) {
                             toVC.view.transform = CGAffineTransformIdentity;
                             fromVC.view.transform = CGAffineTransformIdentity;
                             toVC.view.alpha = 1.0f;
                             [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         }];
    }
}

@end
