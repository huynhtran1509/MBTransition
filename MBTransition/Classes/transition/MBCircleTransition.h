//
//  MBCircleTransition.h
//  MBTransition
//
//  Created by MmoaaY on 15/8/19.
//  Copyright (c) 2015年 MmoaaY. All rights reserved.
//

#import "MBZoomTransition.h"

@protocol RZCirclePushAnimationDelegate <NSObject>

@optional

/**
 *  Calculate the center point, in the from view controller's coordinate space, where the circle transition should be centered.  If not used, the center defaults to the center of the from view controller.
 *
 *  @return the circle transition's center point.
 */
- (CGPoint)circleCenter;

/**
 *  Calculate the radius that the circle transition should start from.  If not used, the radius defaults to the minimum of the from view controller's bounds width or height.
 *
 *  @return the circle transition's starting radius.
 */
- (CGFloat)circleStartingRadius;

@end

@interface MBCircleTransition : MBZoomTransition

@property (nonatomic, weak)     id<RZCirclePushAnimationDelegate> circleDelegate;
@property (nonatomic, assign)   CGFloat maximumCircleScale;
@property (nonatomic, assign)   CGFloat minimumCircleScale;

@end
