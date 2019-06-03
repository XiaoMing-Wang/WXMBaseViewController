//
//  WXMBaseErrorViewProtocol.h
//  MultiProject_Coordination
//
//  Created by edz on 2019/5/31.
//  Copyright © 2019 wq. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WXMErrorStatusProtocolType) {
    
    /** 正常(去掉) */
    WXMErrorProtocolTypeNormal = 0,
    
    /** 无网络 */
    WXMErrorProtocolTypeBadNetwork,
    
    /** 无记录 */
    WXMErrorProtocolTypeNorecord,
    
    /** 请求失败 */
    WXMErrorProtocolTypeRequestFail,
    
    /** 加载中 */
    WXMErrorProtocolTypeRequestLoading,
};

typedef NS_ENUM(NSUInteger, WXMErrorInterfaceType) {
    
    /** 预留 */
    WXMErrorInterfaceTypeNone = 0,
    
    /** 无按钮 */
    WXMErrorInterfaceTypeDefault,
    
    /** 有按钮 */
    WXMErrorInterfaceTypeRefresh,
};

typedef NS_ENUM(NSUInteger, WXMErrorShowType) {
    /** 全屏 */
    WXMErrorShowTypeFullScreen = 0,
    WXMErrorShowTypeFootControls,
};

@protocol WXMBaseErrorViewProtocol <NSObject>
@optional

/** 显示loading */
- (void)wxm_showloadingWithSupControl:(UIView *)supControl;

/** 缺省页最小的高度 (tableFootView剩余高度会比errorView小) */
- (CGFloat)wxm_errorControlMinHeight;


///** 显示缺省页 */
//- (void)wxm_showErrorStatusViewWithType:(WXMErrorStatusProtocolType)errorType;
//
///** 有按钮的回调 */
//- (void)wxm_showErrorStatusRefresh:(void (^)(void))callBack;
//
///** 隐藏缺省页 */
//- (void)wxm_hidenErrorStatusView;

@end

NS_ASSUME_NONNULL_END
