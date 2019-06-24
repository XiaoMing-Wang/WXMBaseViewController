//
//  WXMConmonTransitionNavigationViewController.h
//  ModuleDebugging
//
//  Created by edz on 2019/6/17.
//  Copyright © 2019 wq. All rights reserved.
//
#define UITranProtocol UIViewControllerAnimatedTransitioning
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXMConmonTransitionNavigationViewController : UINavigationController
<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

/** 是否开启自定义转场 */
@property (nonatomic, assign) BOOL wxm_useCustomTransition;

/** presen */
- (id<UITranProtocol>)animationControllerForPresentedController:(UIViewController *)presented
                                           presentingController:(UIViewController *)presenting
                                               sourceController:(UIViewController *)source;
/** dismiss */
- (id<UITranProtocol>)animationControllerForDismissedController:(UIViewController *)dismissed;

/** push pop */
- (id<UITranProtocol>)navigationController:(UINavigationController *)navigationController
           animationControllerForOperation:(UINavigationControllerOperation)operation
                        fromViewController:(UIViewController *)fromVC
                          toViewController:(UIViewController *)toVC;
@end

NS_ASSUME_NONNULL_END
