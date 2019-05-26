//
//  UIView+WXMErrorStatusView.h
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//
#define WXM_MinH 60
#define WXM_ErrorSign 1020
#define WXM_IMGSize CGSizeZero /* CGSizeMake(10, 10) CGSizeZero */
#define WXM_BackgroundColor [UIColor grayColor]
#define WXM_TextColor [UIColor blackColor]
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WXMErrorStatusType) {
    
    /** 正常 */
    WXMErrorStatusTypeNormal = 0,
    
    /** 无网络 */
    WXMErrorStatusTypeBadNetwork,
    
    /** 无记录 */
    WXMErrorStatusTypeNorecord,
    
    /** 请求失败 */
    WXMErrorStatusTypeRequestFail,
    
    /** 加载中 */
    WXMErrorStatusTypeRequestLoading,
};

@interface UIView (WXMErrorStatusView)
- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;
@end

@interface UIViewController (WXMErrorStatusView)
- (void)showErrorStatusViewWithType:(WXMErrorStatusType)errorType;
- (void)hidenErrorStatusView;
@end
