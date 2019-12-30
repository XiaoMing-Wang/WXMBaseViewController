//
//  WXMConmonBaseCustomTransition.h
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WXMBaseCustomTransition : NSObject<UIViewControllerAnimatedTransitioning>

/** 自定义转场动画 */
typedef NS_ENUM(NSUInteger, WXMConmonBaseTransitionType) {
    WXMConmonBaseTransitionTypePresent = 0, /** present */
    WXMConmonBaseTransitionTypeDismiss,     /** dismiss */
    WXMConmonBaseTransitionTypePush,        /** push */
    WXMConmonBaseTransitionTypePOP,         /** pop */
};

@property (nonatomic, assign) WXMConmonBaseTransitionType type;

/** 动画时间 */
@property (nonatomic, assign) CGFloat transitionDuration;
@property (nonatomic, assign) BOOL userInteractionEnabled;

+ (instancetype)transitionWithTransitionType:(WXMConmonBaseTransitionType)type;

/** 子类需要重写 */
- (void)initializeCustomOperation;
- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext;

/** 交互的两个控制器 */
- (UIViewController *)fromViewController:(id<UIViewControllerContextTransitioning>)context;
- (UIViewController *)toViewController:(id<UIViewControllerContextTransitioning>)context;
- (UIView *)fromView:(id<UIViewControllerContextTransitioning>)context;
- (UIView *)toView:(id<UIViewControllerContextTransitioning>)context;
- (UIView *)containerView:(id<UIViewControllerContextTransitioning>)context;

- (void)transitionFinish:(id<UIViewControllerContextTransitioning>)context;
@end
