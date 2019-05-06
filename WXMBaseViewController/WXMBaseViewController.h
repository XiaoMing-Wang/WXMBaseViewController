//
//  WXMBaseViewController.h
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXMBaseViewController : UIViewController

/** 转场动画中 */
@property (nonatomic, assign) BOOL transitions;

/** 加载完成 */
@property (nonatomic, assign) BOOL loaded;

/** 状态栏 */
- (UIStatusBarStyle)statusBarStyle;

/** 手势默认YES */
- (BOOL)interactivePop;

@end
