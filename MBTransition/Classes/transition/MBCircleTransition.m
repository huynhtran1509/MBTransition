//
//  MBCircleTransition.m
//  MBTransition
//
//  Created by MmoaaY on 15/8/19.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

#import "MBCircleTransition.h"

#define kRZCircleDefaultMaxScale    2.5f
#define kRZCircleDefaultMinScale    0.25f
#define kRZCircleAnimationTime      0.5f
#define kRZCircleMaskAnimation      @"kRZCircleMaskAnimation"

@implementation MBCircleTransition

- (id)init
{
    self = [super init];
    if (self) {
        _minimumCircleScale = kRZCircleDefaultMinScale;
        _maximumCircleScale = kRZCircleDefaultMaxScale;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    BOOL reversed = [self isReversedFromViewController:fromVC ToViewController:toVC];
    
    CGRect bounds = toVC.view.bounds;
    CAShapeLayer *circleMaskLayer = [CAShapeLayer layer];
    circleMaskLayer.frame = bounds;
    
    // Caclulate the size the circle should start at
    CGFloat radius = [self circleStartingRadiusWithFromViewController:fromVC withToViewController:toVC];
    
    // Caclulate the center point of the circle
    CGPoint circleCenter = [self circleCenterPointWithFromViewController:fromVC];
    circleMaskLayer.position = circleCenter;
    CGRect circleBoundingRect = CGRectMake(circleCenter.x - radius, circleCenter.y - radius, 2.0*radius, 2.0*radius);
    circleMaskLayer.path = [UIBezierPath bezierPathWithRoundedRect:circleBoundingRect cornerRadius:radius].CGPath;
    circleMaskLayer.bounds = circleBoundingRect;
    
    CABasicAnimation *circleMaskAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    circleMaskAnimation.duration            = duration;
    circleMaskAnimation.repeatCount         = 1.0;    // Animate only once
    circleMaskAnimation.removedOnCompletion = NO;     // Remain after the animation
    
    // Set manual easing on the animation.  Tweak for fun!
    [circleMaskAnimation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.34 :.01 :.69 :1.37]];
    
    if (!reversed)
    {
        [circleMaskAnimation setFillMode:kCAFillModeForwards];
        
        // Animate from small to large
        circleMaskAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
        circleMaskAnimation.toValue   = [NSNumber numberWithFloat:self.maximumCircleScale];
        
        // Add to the view and start the animation
        [toVC.view.layer setMask:circleMaskLayer];
        toVC.view.layer.masksToBounds = YES;
        [circleMaskLayer addAnimation:circleMaskAnimation forKey:kRZCircleMaskAnimation];
    }
    else
    {
        [circleMaskAnimation setFillMode:kCAFillModeForwards];
        
        // Animate from large to small
        circleMaskAnimation.fromValue = [NSNumber numberWithFloat:self.maximumCircleScale];
        circleMaskAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
        
        // Add to the view and start the animation
        [fromVC.view.layer setMask:circleMaskLayer];
        fromVC.view.layer.masksToBounds = YES;
        [circleMaskLayer addAnimation:circleMaskAnimation forKey:kRZCircleMaskAnimation];
    }
    
    [super animateTransition:transitionContext];
}

#pragma mark - Helper Methods

// Caclulate the center point of the circle
- (CGPoint)circleCenterPointWithFromViewController:(UIViewController *)fromVC
{
    CGPoint center = CGPointZero;
    if (self.circleDelegate && [self.circleDelegate respondsToSelector:@selector(circleCenter)])
    {
        center = [self.circleDelegate circleCenter];
    }
    else
    {
        center = CGPointMake(fromVC.view.bounds.origin.x + fromVC.view.bounds.size.width / 2,
                             fromVC.view.bounds.origin.y + fromVC.view.bounds.size.height / 2);
    }
    return center;
}

// Caclulate the size the circle should start at
- (CGFloat)circleStartingRadiusWithFromViewController:(UIViewController *)fromVC
                                 withToViewController:(UIViewController *)toVC
{
    CGFloat radius = 0.0f;
    if (self.circleDelegate && [self.circleDelegate respondsToSelector:@selector(circleStartingRadius)])
    {
        radius = [self.circleDelegate circleStartingRadius];
        CGRect bounds = toVC.view.bounds;
        self.maximumCircleScale = ((MAX(bounds.size.height, bounds.size.width) / (radius)) * 1.25);
    }
    else
    {
        CGRect bounds = fromVC.view.bounds;
        CGFloat diameter = MIN(bounds.size.height, bounds.size.width);
        radius = diameter / 2;
    }
    return radius;
}

@end
