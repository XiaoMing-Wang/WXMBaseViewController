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

/**  presen */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return nil;
}

/** dismiss */
- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return nil;
}
@end
