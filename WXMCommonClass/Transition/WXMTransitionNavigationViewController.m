//
//  WXMConmonTransitionNavigationViewController.m
//  ModuleDebugging
//
//  Created by edz on 2019/6/17.
//  Copyright © 2019 wq. All rights reserved.
//

#import "WXMTransitionNavigationViewController.h"

@interface WXMTransitionNavigationViewController ()

@end

@implementation WXMTransitionNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioningDelegate = self;
    self.delegate = self;
}

/** presen */
- (id<UITranProtocol>)animationControllerForPresentedController:(UIViewController *)presented
                                           presentingController:(UIViewController *)presenting
                                               sourceController:(UIViewController *)source {
    return nil;
}

/** dismiss */
- (id<UITranProtocol>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return nil;
}

/** push pop */
- (id<UITranProtocol>)navigationController:(UINavigationController *)navigationController
           animationControllerForOperation:(UINavigationControllerOperation)operation
                        fromViewController:(UIViewController *)fromVC
                          toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        
        
    } else if (operation == UINavigationControllerOperationPop) {
        
        
    }
    return nil;
}
@end
