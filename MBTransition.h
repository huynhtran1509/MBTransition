#import <Foundation/Foundation.h>

typedef enum TransitionType{
    TransitionTypePush,
    TransitionTypePresent
}TransitionType;

@interface MBTransition : NSObject<UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UIViewController *fromVC;
@property (nonatomic, weak) UIViewController *toVC;
@property (nonatomic, assign) NSTimeInterval duration;

+ (instancetype)shared;

- (BOOL)isReversed:(UIViewController *)fromVC ToVC:(UIViewController *)toVC;
- (void)setTransitionWithFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC TransitionType:(TransitionType)type Duration:(NSTimeInterval)duration;

@end
