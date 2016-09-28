//
//  MBTransition.m
//  MBTransition
//
//  Created by MmoaaY on 15/8/19.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

#import "MBTransition.h"

@interface MBTransition()

@end

@implementation MBTransition

#pragma mark - Setup & Initializers


#pragma mark - Public Methods

- (BOOL)isReversedFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC
{
    return ([self.fromVC class] == [toVC class] && [self.toVC class] == [fromVC class]);
}

- (instancetype)initWithFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC Duration:(NSTimeInterval)duration
{
    self = [super init];
    if (self) {
        _fromVC = fromVC;
        _toVC = toVC;
        _duration = duration;
    }
    return self;
}

#pragma mark - UIViewControllerContextTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

@end
