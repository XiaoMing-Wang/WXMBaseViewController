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

@interface WXMBaseThemeButton : UIButton

typedef NS_ENUM(NSInteger, WXMStateButtonState) {

    /** 默认 */
    WXMStateButtonStateNormal = 0,

    /** 不可用 */
    WXMStateButtonStateDisabled,

    /** 加载中 */
    WXMStateButtonStateLoading,
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
