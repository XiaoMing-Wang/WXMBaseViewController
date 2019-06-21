//
//  WXMBaseButtonView.h
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//

#define WXMThemeMargin 20
#define WXMThemeHeight 49
#define WXMThemeFontSize 16
#define WXMThemeCornerRadius 8
#define WXMThemeBackgroundColor WXM_buttonDefaultColor()
#define WXMThemetTitleColor [UIColor whiteColor]

#import <UIKit/UIKit.h>
#import "WXMGlobalStaticFile.h"

@interface WXMCommonBaseThemeButton : UIButton

typedef NS_ENUM(NSInteger, WXMCommonStateButtonState) {

    /** 默认 */
    WXMCommonStateButtonStateNormal = 0,

    /** 不可用 */
    WXMCommonStateButtonStateDisabled,

    /** 加载中 */
    WXMCommonStateButtonStateLoading,
};

@property (nonatomic, assign) WXMCommonStateButtonState buttonState;

/** 主题 */
+ (WXMCommonBaseThemeButton *)wxm_themeButtonWithTitle:(NSString *)title;
+ (WXMCommonBaseThemeButton *)wxm_themeButtonDisabledWithTitle:(NSString *)title;

/** 设置背景色 */
- (void)wxm_setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/** 设置字体色 */
- (void)wxm_setTitleColor:(UIColor *)color forState:(UIControlState)state;

@end
