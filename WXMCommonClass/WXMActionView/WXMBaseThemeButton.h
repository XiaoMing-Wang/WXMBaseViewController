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

typedef NS_ENUM(NSInteger, WXMStateButtonState) {

    /** 默认 */
    WXMStateButtonStateNormal = 0,

    /** 不可用 */
    WXMStateButtonStateDisabled,
};

@property (nonatomic, assign) WXMStateButtonState buttonState;

/** 主题 */
+ (WXMBaseThemeButton *)themeButtonWithTitle:(NSString *)title;
+ (WXMBaseThemeButton *)themeButtonDisabledWithTitle:(NSString *)title;

/** 设置背景色 */
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/** 设置字体色 */
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

@end
