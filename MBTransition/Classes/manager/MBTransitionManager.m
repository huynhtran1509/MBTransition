//
//  MBTransitionManager.m
//  MBTransition
//
//  Created by MmoaaY on 16/6/16.
//  Copyright © 2016年 MmoaaY. All rights reserved.
//

#import "MBTransitionManager.h"
#import "UIViewController+MBTransitionAddition.h"

@interface MBTransitionManager()

@property (nonatomic, strong) NSMutableArray *transitions;

@end

@implementation MBTransitionManager

+ (instancetype)shared
{
    static MBTransitionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MBTransitionManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _transitions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) cleanInvalidTransitions {
    for (int i = 0; i < self.transitions.count; i++) {
        MBTransition *transition = [self.transitions objectAtIndex:i];
        if (!transition.fromVC || !transition.toVC) {
            [self.transitions removeObject:transition];
        }
    }
}

- (void) registerNavigtation:(UINavigationController *)nav {
    nav.delegate = self;
}

-(void) registerTranstion:(MBTransition *)transition {
    [self cleanInvalidTransitions];
    if (![self transitionForFromViewController:transition.fromVC ToViewController:transition.toVC]) {
        [self.transitions addObject:transition];
    }
    transition.fromVC.transitioningDelegate = self;
    transition.toVC.transitioningDelegate = self;
}

-(MBTransition *)transitionForFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC {
    for (int i = 0; i < self.transitions.count; i++) {
        MBTransition *transition = [self.transitions objectAtIndex:i];
        if ([transition.fromVC class] == [fromVC class] && [transition.toVC class] == [toVC class]) {
            return transition;
        }
        if ([transition.fromVC class] == [toVC class] && [transition.toVC class] == [fromVC class]) {
            [self.transitions removeObject:transition];
            return transition;
        }
    }
    return nil;
}

-(MBTransition *)transitionForToViewController:(UIViewController *)toVC {
    for (int i = 0; i < self.transitions.count; i++) {
        MBTransition *transition = [self.transitions objectAtIndex:i];
        if ([transition.toVC class] == [toVC class]) {
            return transition;
        }
    }
    return nil;
}

#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    return [self transitionForFromViewController:fromVC ToViewController:toVC];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController.navigationController.navigationBarHidden != [viewController navigationBarHidden]) {
        [viewController.navigationController setNavigationBarHidden:[viewController navigationBarHidden] animated:YES];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self transitionForFromViewController:source ToViewController:presenting];
}

-(id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self transitionForToViewController:dismissed];
}


@end
