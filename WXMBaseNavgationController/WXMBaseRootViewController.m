//
//  WXMRootViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2020/5/13.
//  Copyright © 2020 wxm. All rights reserved.
//

#import "WXMBaseRootViewController.h"
#import "WXMBaseTabBarViewController.h"
#import "HomeViewController.h"

@interface WXMBaseRootViewController ()
@property (nonatomic, weak) WXMBaseTabBarViewController *tabBarVC;
@end

@implementation WXMBaseRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES animated:NO];
}

/** 单例 */
+ (WXMBaseRootViewController *)shareRoot {
    static WXMBaseRootViewController *rootController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WXMBaseTabBarViewController *tabBarVC = [[WXMBaseTabBarViewController alloc] init];
        rootController = [[WXMBaseRootViewController alloc] initWithRootViewController:tabBarVC];
        rootController.tabBarVC = tabBarVC;
    });
    return rootController;
}

/** TabBar控制器 */
- (WXMBaseTabBarViewController *)tabBarViewController {
    return self.tabBarVC;
}

/** TabBar控制器选中的导航栏 */
- (UINavigationController *)tabNavigationController {
    return (UINavigationController *) self.tabBarViewController.selectedViewController;
}

/** 重置TabBar */
- (void)resetTabBarViewController {
    WXMBaseTabBarViewController *tabBarVC = [[WXMBaseTabBarViewController alloc] init];
    self.tabBarVC = tabBarVC;
    self.viewControllers = @[tabBarVC];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) viewController.hidesBottomBarWhenPushed = YES;
    if (self.viewControllers.count == 0) viewController.hidesBottomBarWhenPushed = NO;
    [[[[UIApplication sharedApplication] delegate] window] endEditing:YES];
    [super pushViewController:viewController animated:animated];
}

@end


