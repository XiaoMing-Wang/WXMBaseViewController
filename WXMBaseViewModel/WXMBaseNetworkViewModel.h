//
//  WXMBaseNetworkViewModel.h
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "NSMutableArray+WXMKVOKit.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WXMExistCacheType) {
    WXMExistCacheTypeNone = 0,   /** 无缓存 */
    WXMExistCacheTypeExistCache, /** 有缓存 */
};

typedef NS_ENUM(NSUInteger, WXMRequestType) {
    WXMRequestTypeSuccess = 0, /** 状态码0 */
    WXMRequestTypeErrorCode,   /** 请求成功但是状态码不为0 */
    WXMRequestTypeFail,        /** 请求异常 */
    WXMRequestTypeLoadCache,   /** 加载缓存刷新 */
};

typedef NS_ENUM(NSUInteger, WXMRefreshType) {
    WXMRefreshFreedom = 0,   /** 自由状态 */
    WXMRefreshHeaderControl, /** 头部 */
    WXMRefreshFootControl,   /** 尾部 */
};

@protocol WXMNetworkViewModelProtocol <NSObject>
@optional
- (NSArray *)wxm_networkWithDataSourceCache;
@end

@interface WXMBaseNetworkViewModel : NSObject

@property(nonatomic, assign) NSInteger lastPage;
@property(nonatomic, assign) NSInteger currentPage;

/** 缓存状态 */
@property(nonatomic, assign) WXMExistCacheType existCache;

/** 刷新状态 */
@property(nonatomic, assign) WXMRefreshType refreshType;

/** 请求状态 */
@property(nonatomic, assign) BOOL isRequestting;

/* 网络请求 */
@property(nonatomic, strong, readonly) RACCommand *requestCommand;
@property(nonatomic, strong, readwrite) NSMutableArray *dataSource;
@property(nonatomic, weak, readonly) UIViewController <WXMNetworkViewModelProtocol>*controller;

/** 刷新 */
- (void)wxm_pullRefreshHeaderControl;
- (void)wxm_pullRefreshFootControl;

/** 获取缓存 */
- (WXMExistCacheType)wxm_subclassCacheType;
- (RACSignal *)wxm_requestDataSourceRACSignal;
+ (instancetype)wxm_networkWithViewController:(UIViewController *)controller;
@end
NS_ASSUME_NONNULL_END

