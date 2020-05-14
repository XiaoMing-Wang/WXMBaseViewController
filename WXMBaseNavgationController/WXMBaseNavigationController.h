//
//  WXMBaseNavigationController.h
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMNavigationController.h"

@interface WXMBaseNavigationController  : UINavigationController
<UINavigationControllerDelegate,  UIViewControllerTransitioningDelegate>

/** 渐现动画动画 */
@property (nonatomic, assign) BOOL presentAnimation;
@property (nonatomic, assign) BOOL dismissAnimation;

@end

