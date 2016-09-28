//
//  MBSharedViewTransition.m
//  MBTransition
//
//  Created by MmoaaY on 09/08/2014.
//  Copyright (c) 2014 MmoaaY. All rights reserved.
//

#import "MBSharedViewTransition.h"

@interface MBSharedViewTransition ()

@property (nonatomic, weak) UIViewController<MBSharedViewTransitionDataSource> *shareViewFromVC;
@property (nonatomic, weak) UIViewController<MBSharedViewTransitionDataSource> *shareViewToVC;

@end

@implementation MBSharedViewTransition

#pragma mark - Setup & Initializers
#pragma mark - Public Methods

- (instancetype)initWithFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC ShareViewFromViewController:(UIViewController<MBSharedViewTransitionDataSource> *)shareViewFromVC ShareViewToViewController:(UIViewController<MBSharedViewTransitionDataSource> *)shareViewToVC Duration:(NSTimeInterval)duration
{
    if (self = [super initWithFromViewController:fromVC ToViewController:toVC Duration:duration]) {
        self.shareViewFromVC = shareViewFromVC;
        self.shareViewToVC = shareViewToVC;
    }
    
    return self;
}

#pragma mark - UIViewControllerContextTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    BOOL reversed = [self isReversedFromViewController:fromVC ToViewController:toVC];
    
    UIView *fromView = nil;
    UIView *toView = nil;
    if (reversed) {
        fromView = [self.shareViewToVC sharedView];
        toView = [self.shareViewFromVC sharedView];
    } else {
        fromView = [self.shareViewFromVC sharedView];
        toView = [self.shareViewToVC sharedView];
    }
    
    // Take Snapshot of fomView
    UIView *snapshotView = [fromView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    fromView.hidden = YES;
    
    // Setup the initial view states
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    if (reversed) {
        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    }
    else {
        toVC.view.alpha = 0.0;
        [containerView addSubview:toVC.view];
    }
    
    [containerView addSubview:snapshotView];
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (!reversed) {
            toVC.view.alpha = 1.0; // Fade in
        }
        else {
            fromVC.view.alpha = 0.0; // Fade out
        }
        
        snapshotView.alpha = 0.0;
        // Move the SnapshotView
        if (!reversed){
            snapshotView.frame = toView.frame;
        }
    } completion:^(BOOL finished) {
        // Clean up
        fromView.hidden = NO;
        [snapshotView removeFromSuperview];
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
