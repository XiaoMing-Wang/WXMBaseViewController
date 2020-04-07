//
//  WXMGlobalStaticFile.h
//  ModuleDebugging
//
//  Created by edz on 2019/6/21.
//  Copyright © 2019 wq. All rights reserved.
//
/**  颜色(0xFFFFFF) 不用带 0x 和 @"" */
#define WXMCOLOR_WITH_HEX(hexValue) \
[UIColor colorWith\
Red:((float)((0x##hexValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((0x##hexValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(0x##hexValue & 0xFF)) / 255.0 alpha:1.0f]

/** iphoneX */
#define WXMIPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);\
})

#define WXMBase_Width [UIScreen mainScreen].bounds.size.width
#define WXMBase_Height [UIScreen mainScreen].bounds.size.height
#define WXMBase_BarHeight ((WXMIPhoneX) ? 88.0f : 64.0f)
#define WXMBase_Rect \
CGRectMake(0, WXMBase_BarHeight, WXMBase_Width, WXMBase_Height - WXMBase_BarHeight)

#ifndef WXMGlobalStaticFile_h
#define WXMGlobalStaticFile_h
#import <UIKit/UIKit.h>

#pragma mark  文字
#pragma mark  文字
#pragma mark  文字

/** 文字(主色) */
static inline UIColor *kTextDefaultColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

/** 文字描述 */
static inline UIColor *kTextDescribeColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

/** textField */
static inline UIColor *kTextFieldColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

/** 按钮(主色) */
static inline UIColor *kButtonDefaultColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

/** 按钮不可用 */
static inline UIColor *kButtonUnusableColor() {
    return WXMCOLOR_WITH_HEX(002632);
}


#pragma mark  导航栏
#pragma mark  导航栏
#pragma mark  导航栏

/** 导航栏颜色 */
static inline UIColor *kNavigationColor() {
    return WXMCOLOR_WITH_HEX(FFFFFF);
}

/** 导航栏标题颜色 */
static inline UIColor *kNavigationTitleColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

#pragma mark  view
#pragma mark  view
#pragma mark  view

/** view(主色) */
static inline UIColor *kViewBackgroundColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

#pragma mark ____________________________________ 字体

static inline UIFont *kFont24() {
    return [UIFont systemFontOfSize:24];
}
static inline UIFont *kFont20() {
    return [UIFont systemFontOfSize:20];
}
static inline UIFont *kFont18() {
    return [UIFont systemFontOfSize:18];
}
static inline UIFont *kFont16() {
    return [UIFont systemFontOfSize:16];
}
static inline UIFont *kFont14() {
    return [UIFont systemFontOfSize:14];
}
static inline UIFont *kFont12() {
    return [UIFont systemFontOfSize:12];
}
static inline UIFont *kFont11() {
    return [UIFont systemFontOfSize:11];
}
static inline UIFont *kFont8() {
    return [UIFont systemFontOfSize:8];
}

/** 粗体 */
static inline UIFont *kBfont24() {
    return [UIFont boldSystemFontOfSize:24];
}
static inline UIFont *kBfont20() {
    return [UIFont boldSystemFontOfSize:20];
}
static inline UIFont *kBfont18() {
    return [UIFont boldSystemFontOfSize:18];
}
static inline UIFont *kBfont16() {
    return [UIFont boldSystemFontOfSize:16];
}
static inline UIFont *kBfont14() {
    return [UIFont boldSystemFontOfSize:14];
}
static inline UIFont *kBfont12() {
    return [UIFont boldSystemFontOfSize:12];
}
static inline UIFont *kBfont11() {
    return [UIFont boldSystemFontOfSize:11];
}
static inline UIFont *kBfont8() {
    return [UIFont boldSystemFontOfSize:8];
}
#endif /* WXMGlobalStaticFile_h */
