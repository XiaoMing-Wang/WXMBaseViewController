//
//  WXMActionCconfiguration.h
//  Multi-project-coordination
//
//  Created by wq on 2020/1/1.
//  Copyright © 2020 wxm. All rights reserved.
//

#ifndef WXMActionCconfiguration_h
#define WXMActionCconfiguration_h

/** 标题字体 */
#define WXMCommonTitleFont 16

/** 描述字体 */
#define WXMCommonDetailFont 14

/** 描述字体 */
#define WXMCommonSubDetailFont 12

/** 线条左边边距 */
#define WXMCommonLineX 16

/** 标题颜色 */
#define WXMCommonTitleColor [UIColor blackColor]

/** 描述字体 */
#define WXMCommonDetailColor [UIColor blackColor]

/** 小号描述 */
#define WXMCommonSubDetailColor [UIColor blackColor]

/** 占位字体颜色 */
#define WXMCommonPlaceColor [UIColor lightGrayColor]

/** 线条 */
#define WXMCommonLineColor [UIColor grayColor]

/** 按钮左右边距 */
#define WXMThemeMargin 20

/** 按钮高度 */
#define WXMThemeHeight 49

/** 按钮字号 */
#define WXMThemeFontSize 16

/** 按钮圆角 */
#define WXMThemeCornerRadius 8

/** 按钮主题颜色 */
#define WXMThemeBackgroundColor WXM_buttonDefaultColor()

/** 按钮标题颜色 */
#define WXMThemetTitleColor [UIColor whiteColor]

#define WXMCommonWidth [UIScreen mainScreen].bounds.size.width

/** 线条类型 */
typedef NS_ENUM(NSUInteger, WXMCommonTextFieldLineType) {
    WXMCommonTextFieldLineTypeNone = 0,
    WXMCommonTextFieldLineTypeTop,
    WXMCommonTextFieldLineTypeBottom,
    WXMCommonTextFieldLineTypeBoth,
};

#endif /* WXMActionCconfiguration_h */
