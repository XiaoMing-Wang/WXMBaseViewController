//
//  WXMBaseNetworkhandler.h
//  WXMComponentization
//
//  Created by sdjim on 2020/4/2.
//  Copyright © 2020 sdjim. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WXMBaseReplaceMacro.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WXMRefreshType) {
    WXMRefreshFreedom = 0,   /** 自由状态 */
    WXMRefreshHeaderControl, /** 头部 */
    WXMRefreshFootControl,   /** 尾部 */
};

typedef void (^NetworkHandlerVoid) (void);
typedef void (^NetworkHandlerID) (id response);
@protocol WXMBaseNetworkHandlerProtocol <NSObject>
@optional
- (void)wt_requestSuccessWithArray:(NSArray *)arrays;
- (void)wt_requestSuccessWithEvent:(NSString *)event object:(id)object;
- (void)wt_requestFailWithEvent:(NSString *)event object:(id)object;
@end

@interface WXMBaseAutomaticImpModel : NSObject @end
@interface WXMBaseNetworkHandler : NSObject <WXMHandlerProtocol>

/** 回调代理 */
@property (nonatomic, weak, readonly) id <WXMBaseNetworkHandlerProtocol>delegate;

/** 新旧页码 */
@property (nonatomic, assign) NSInteger lastPage;
@property (nonatomic, assign) NSInteger currentPage;

/** 刷新状态 */
@property (nonatomic, assign) WXMRefreshType refreshType;

/** 请求状态 */
@property (nonatomic, assign) BOOL isRequestting;

/* 网络请求数据 */
@property (nonatomic, strong, readwrite) NSMutableArray *dataSource;

/** 初始化 */
- (instancetype)initWithDelegate:(id<WXMBaseNetworkHandlerProtocol>)delegate;

/** 设置默认数据 */
- (void)initializationVariable;

/** 内部调用 处理一致的回调 */
/** 内部调用 处理一致的回调 */
/** 内部调用 处理一致的回调 */
- (void)callSuccessWithArray:(nullable NSArray *)arrays;
- (void)callSuccessWithEvent:(nullable NSString *)event object:(nullable id)object;
- (void)callFailWithEvent:(nullable NSString *)event object:(nullable id)object;

@end

NS_ASSUME_NONNULL_END
