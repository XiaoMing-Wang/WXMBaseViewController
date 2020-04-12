//
//  WXMBaseNetworkhandler.h
//  WXMComponentization
//
//  Created by sdjim on 2020/4/2.
//  Copyright © 2020 sdjim. All rights reserved.
//
/** 属性点语法加上这行 */
#define SINGLETON_HANDLE_CLASS(CLASS) \
+ (CLASS *(^)(id<WXMBaseNetworkHandlerProtocol> delegate))singletonhandler;

/** 声明httpReq对象和实现 强制申明是为了保证httpReq参数名共用 */
#define SINGLETON_HANDLE_REQ_DEFINE(CLASS) @property (nonatomic, strong) CLASS *httpReq;
#define SINGLETON_HANDLE_REQ_IMPEMENT(CLASS) \
@synthesize httpReq = _httpReq; \
- (CLASS *)httpReq { \
    if (_httpReq == nil) _httpReq = [[CLASS alloc] init]; \
    return _httpReq;\
}


#define NO_CALLBACK_NIL if (!callBack) return;
#define NO_PARAMETER_NIL(parameter) if (!parameter) return;

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WXMRefreshType) {
    WXMRefreshFreedom = 0,   /** 自由状态 */
    WXMRefreshHeaderControl, /** 头部 */
    WXMRefreshFootControl,   /** 尾部 */
};

@protocol WXMBaseNetworkHandlerProtocol <NSObject>
@optional
- (void)wt_requestSuccessWithArray:(NSArray *)arrays;
- (void)wt_requestSuccessWithEvent:(NSString *)event object:(id)object;
- (void)wt_requestFailWithEvent:(NSString *)event object:(id)object;
@end

@class BaseModel;
@interface WXMBaseNetworkHandler : NSObject

/** 请求参数 */
@property (nonatomic, strong) NSObject *httpReq;

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
+ (instancetype)handler;
+ (instancetype (^)(id<WXMBaseNetworkHandlerProtocol> delegate))singletonhandler;
- (instancetype)initWithDelegate:(id<WXMBaseNetworkHandlerProtocol>)delegate;

/** 内部调用 处理一致的回调 不一致用block */
- (void)callSuccessWithArray:(nullable NSArray *)arrays;
- (void)callSuccessWithEvent:(nullable NSString *)event object:(nullable id)object;
- (void)callFailWithEvent:(nullable NSString *)event object:(nullable id)object;
@end


NS_ASSUME_NONNULL_END
