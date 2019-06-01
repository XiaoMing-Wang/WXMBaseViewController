//
//  UIView+WXMErrorStatusView.h
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//
#define WXM_ERGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define WXM_MinH 60
#define WXM_ErrorSign 1020
#define WXM_Offset -35
#define WXM_OffsetRefresh -55
#define WXM_RefreshMargin 30
#define WXM_RefreshCornerRadius 8
#define WXM_IMGSize CGSizeZero /* CGSizeMake(10, 10) CGSizeZero */

#define WXM_BackgroundColor WXM_ERGBColor(240, 240, 240)
#define WXM_TextColor WXM_ERGBColor(55, 55, 55)
#define WXM_RefreshBgcolor WXM_ERGBColor(30, 144, 255)
#define WXM_RefreshTextcolor [UIColor whiteColor]

#define WXM_RefreshText @"点击刷新"

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WXMErrorStatusType) {
    WXMErrorStatusTypeNormal = 0,     /** 正常 */
    WXMErrorStatusTypeBadNetwork,     /** 无网络 */
    WXMErrorStatusTypeNorecord,       /** 无记录 */
    WXMErrorStatusTypeRequestFail,    /** 请求失败 */
    WXMErrorStatusTypeRequestLoading, /** 加载中 */
};

typedef NS_ENUM(NSUInteger, WXMErrorStatusInterfaceType) {
    WXMErrorFaceTypeNone = 0, /** 预留 */
    WXMErrorFaceTypeDefault,  /** 无按钮 */
    WXMErrorFaceTypeRefresh,  /** 有按钮 */
};

@interface UIView (WXMErrorStatusView)
- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;
@end

@interface UIViewController (WXMErrorStatusView)
- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;
@end
