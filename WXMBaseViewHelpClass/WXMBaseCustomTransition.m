//
//  WXMConmonBaseCustomTransition.m
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseCustomTransition.h"

@implementation WXMBaseCustomTransition

+ (instancetype)transitionWithTransitionType:(WXMConmonBaseTransitionType)type {
    WXMBaseCustomTransition *transition = [[self alloc] init];
    transition.type = type;
    transition.transitionDuration = -1;
    transition.userInteractionEnabled = YES;
    [transition initializeCustomOperation];
    return transition;
}

/** 自定义 */
- (void)initializeCustomOperation {
    
}

/** 动画时间 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return  (_transitionDuration > 0) ? _transitionDuration : .25f;
}

/** 跳转类型 进入和返回 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case WXMConmonBaseTransitionTypePresent: [self present:transitionContext]; break;
        case WXMConmonBaseTransitionTypeDismiss: [self dismiss:transitionContext]; break;
        case WXMConmonBaseTransitionTypePush: [self push:transitionContext]; break;
        case WXMConmonBaseTransitionTypePOP: [self pop:transitionContext]; break;
        default: break;
    }
}

/** present */
- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {}

/** dismiss */
- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {}

/** push */
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {}

/** pop */
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {}

/** 转场前一个UIViewController */
- (UIViewController *)fromViewController:(id<UIViewControllerContextTransitioning>)context {
    return [context viewControllerForKey:UITransitionContextFromViewControllerKey];
}

/** 转场后一个UIViewController */
- (UIViewController *)toViewController:(id<UIViewControllerContextTransitioning>)context {
    return [context viewControllerForKey:UITransitionContextToViewControllerKey];
}

/** 转场前一个UIViewController.view */
- (UIView *)fromView:(id<UIViewControllerContextTransitioning>)context {
    return [self fromViewController:context].view;
}

/** 转场后一个UIViewController.view */
- (UIView *)toView:(id<UIViewControllerContextTransitioning>)context {
    return [self toViewController:context].view;
}

/** 转场containerView */
- (UIView *)containerView:(id<UIViewControllerContextTransitioning>)context {
    return [context containerView];
}

/** 转场结束 */
- (void)transitionFinish:(id<UIViewControllerContextTransitioning>)context {
    [context completeTransition:![context transitionWasCancelled]];
}

@end


@implementation WXMBaseFadeTransition

/** present */
- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [self toViewController:transitionContext];
    UIView *containerView = [self containerView:transitionContext];
    
    toViewController.view.alpha = 0;
    [containerView addSubview:toViewController.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toViewController.view.alpha = 1;
        
    } completion:^(BOOL finished) { finished ? [self transitionFinish:transitionContext] : nil ; }];
}

/** dismiss */
- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [self fromViewController:transitionContext];
    UIViewController *toViewController = [self toViewController:transitionContext];
    
    UIView *containerView = [self containerView:transitionContext];
    [containerView insertSubview:toViewController.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] * 1. animations:^{
        
        fromViewController.view.alpha = 0;
        
    } completion:^(BOOL finished) { finished ? [self transitionFinish:transitionContext] : nil ; }];
}

@end
