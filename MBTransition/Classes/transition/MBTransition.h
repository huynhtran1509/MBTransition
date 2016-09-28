//
//  MBTransition.h
//  MBTransition
//
//  Created by MmoaaY on 15/8/19.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MBTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) UIViewController *fromVC;
@property (nonatomic, weak) UIViewController *toVC;
@property (nonatomic, assign) NSTimeInterval duration;

- (BOOL)isReversedFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC;
- (instancetype)initWithFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC Duration:(NSTimeInterval)duration;

@end
