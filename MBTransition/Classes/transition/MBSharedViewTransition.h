//
//  MBSharedViewTransition.h
//  MBTransition
//
//  Created by MmoaaY on 09/08/2014.
//  Copyright (c) 2014 MmoaaY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBTransition.h"

@protocol MBSharedViewTransitionDataSource <NSObject>

- (UIView *)sharedView;

@end

@interface MBSharedViewTransition : MBTransition

- (instancetype)initWithFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC ShareViewFromViewController:(UIViewController<MBSharedViewTransitionDataSource> *)shareViewFromVC ShareViewToViewController:(UIViewController<MBSharedViewTransitionDataSource> *)shareViewToVC Duration:(NSTimeInterval)duration;

@end
