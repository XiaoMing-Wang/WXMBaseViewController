//
//  WXMBaseButtonView.h
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMGlobalStaticFile.h"
#import "WXMActionCconfiguration.h"

@interface WXMBaseThemeButton : UIButton

/** 主题 */
+ (WXMBaseThemeButton *)themeButtonWithTitle:(NSString *)title;
+ (WXMBaseThemeButton *)themeButtonDisabledWithTitle:(NSString *)title;

/** 设置title */
- (void)setTitle:(NSString *)title;

/** 设置背景色 */
- (void)setBackgroundColor:(UIColor *)color;
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/** 设置字体色 */
- (void)setTitleColor:(UIColor *)color;
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

@end
