//
//  MBTransitionManager.h
//  MBTransition
//
//  Created by MmoaaY on 16/6/16.
//  Copyright © 2016年 MmoaaY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBTransition.h"

@interface MBTransitionManager : NSObject<UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

+ (instancetype)shared;

-(void) registerTranstion:(MBTransition *)transition;
-(void) registerNavigtation:(UINavigationController *)nav;

@end
