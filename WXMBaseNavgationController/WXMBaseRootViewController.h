//
//  WXMRootViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2020/5/13.
//  Copyright © 2020 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMBaseCustomTransition.h"
#import "WXMBaseTabBarViewController.h"

NS_ASSUME_NONNULL_BEGIN

/** 导航控制器-->TabBar控制器-->导航控制器 */
@interface WXMBaseRootViewController : UINavigationController

/** 自定义动画(如登录) */
@property (nonatomic, assign) BOOL presentAnimation;
@property (nonatomic, assign) BOOL dismissAnimation;

/** 单例 */
+ (WXMBaseRootViewController *)shareRoot;

/** TabBar控制器 */
- (WXMBaseTabBarViewController *)tabBarViewController;

/** TabBar控制器选中的导航栏 */
- (UINavigationController *)tabNavigationController;

/** 重置TabBar */
- (void)resetTabBarViewController;

@end

NS_ASSUME_NONNULL_END
