#import "MBTransition.h"

@interface MBTransition()

@end

@implementation MBTransition

#pragma mark - Setup & Initializers

+ (instancetype)shared
{
    static MBTransition *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MBTransition alloc] init];
    });
    return instance;
}

#pragma mark - Public Methods

- (BOOL)isReversed:(UIViewController *)fromVC ToVC:(UIViewController *)toVC
{
    return !([self.fromVC class] == [fromVC class] && [self.toVC class] == [toVC class]);
}


- (void)setTransitionWithFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC TransitionType:(TransitionType)type Duration:(NSTimeInterval)duration{
    
    self.fromVC = fromVC;
    self.toVC = toVC;
    self.duration = duration;
    if (type == TransitionTypePush) {
        self.fromVC.navigationController.delegate = self;
    }else if (type == TransitionTypePresent){
        self.fromVC.transitioningDelegate = self;
        self.toVC.transitioningDelegate = self;
    }
}

#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

-(id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

#pragma mark - UIViewControllerContextTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

@end
