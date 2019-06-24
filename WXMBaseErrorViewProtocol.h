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
    WXMErrorProtocolTypeNormal = 0,     /** 正常(去掉) */
    WXMErrorProtocolTypeBadNetwork,     /** 无网络 */
    WXMErrorProtocolTypeNorecord,       /** 无记录 */
    WXMErrorProtocolTypeRequestFail,    /** 请求失败 */
    WXMErrorProtocolTypeRequestLoading, /** 加载中 */
};

typedef NS_ENUM(NSUInteger, WXMErrorInterfaceType) {
    WXMErrorInterfaceTypeNone = 0, /** 预留 */
    WXMErrorInterfaceTypeDefault,  /** 无按钮 */
    WXMErrorInterfaceTypeRefresh,  /** 有按钮 */
};

@protocol WXMBaseErrorViewProtocol <NSObject>
@optional

/** loading */
- (void)wxm_showloadingWithSupView:(UIView *)supView;
- (void)wxm_hiddenLoadingView;

/** 缺省图 */
- (void)wxm_showErrorView:(UIView *)supView protocolType:(WXMErrorStatusProtocolType)proType;
- (void)wxm_removeErrorView;

/** 缺省页最小的高度 (tableFootView剩余高度会比errorControl小) */
- (CGFloat)wxm_errorControlMinHeight;

@end

NS_ASSUME_NONNULL_END
