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

/** 文字(主色) */
static inline UIColor *WXM_textDefaultColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

/** 按钮(主色) */
static inline UIColor *WXM_buttonDefaultColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

/** view(主色) */
static inline UIColor *WXM_viewBackgroundColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

/** 文字描述 */
static inline UIColor *WXM_textDescribeColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

/** textField */
static inline UIColor *WXM_textFieldColor() {
    return WXMCOLOR_WITH_HEX(002632);
}

#pragma mark ____________________________________ 字体

static inline UIFont *YDO_font24() {
    return [UIFont systemFontOfSize:24];
}
static inline UIFont *YDO_font20() {
    return [UIFont systemFontOfSize:20];
}
static inline UIFont *YDO_font18() {
    return [UIFont systemFontOfSize:18];
}
static inline UIFont *YDO_font16() {
    return [UIFont systemFontOfSize:16];
}
static inline UIFont *YDO_font14() {
    return [UIFont systemFontOfSize:14];
}
static inline UIFont *YDO_font12() {
    return [UIFont systemFontOfSize:12];
}
static inline UIFont *YDO_font11() {
    return [UIFont systemFontOfSize:11];
}
static inline UIFont *YDO_font8() {
    return [UIFont systemFontOfSize:8];
}


#endif /* WXMGlobalStaticFile_h */
