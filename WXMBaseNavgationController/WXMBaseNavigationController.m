//
//  WXMBaseNavigationController.m
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//

#import "WXMBaseNavigationController.h"

@interface WXMBaseNavigationController ()

@end

@implementation WXMBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioningDelegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) viewController.hidesBottomBarWhenPushed = YES;
    if (self.viewControllers.count == 0) viewController.hidesBottomBarWhenPushed = NO;
    [[[[UIApplication sharedApplication] delegate] window] endEditing:YES];
    [super pushViewController:viewController animated:animated];
}

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController :(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return nil;
}

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController :(UIViewController *)dismissed {
    return nil;
}
@end
