//
//  WXMBaseNetworkViewModel.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#define WXM_CacheSignal @"WXM_CacheSignal"
#import "WXMBaseNetworkViewModel.h"
@interface WXMBaseNetworkViewModel ()
@property(nonatomic, weak, readwrite) UIViewController <WXMNetworkViewModelProtocol>*controller;
@end
@implementation WXMBaseNetworkViewModel

+ (instancetype)wxm_networkWithViewController:(UIViewController <WXMNetworkViewModelProtocol> *)controller {
    WXMBaseNetworkViewModel *networkViewModel = [[self alloc] initWithController:controller];
    return networkViewModel;
}
- (instancetype)initWithController:(UIViewController<WXMNetworkViewModelProtocol>*)controller {
    if (self = [super init]) {
       
        _lastPage = 1;
        _currentPage = 1;
        _isRequestting = NO;
        _dataSource = @[].mutableCopy;
        _refreshType = WXMRefreshFreedom;
        _controller = controller;
        _existCache = [self wxm_subclassCacheType];
        [_dataSource wxm_setObserver:self selector:@selector(dataSource)];
        [self wxm_initRequestCommand];
        [self wxm_listeningdataSourceObserver];
    }
    return self;
}

/** 由controller回调缓存 */
- (WXMExistCacheType)wxm_subclassCacheType {
    _existCache = WXMExistCacheTypeNone;
    
    /** controller实现了wxm_networkWithDataSourceCache */
    if ([self.controller respondsToSelector:@selector(wxm_networkWithDataSourceCache)]) {
        NSArray * cacheArray = [self.controller wxm_networkWithDataSourceCache];
        if (cacheArray.count > 0) _existCache = WXMExistCacheTypeExistCache;
        [self.dataSource addObjectsFromArray:cacheArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.requestCommand execute:WXM_CacheSignal];
        });
    }
    return _existCache;
}

/** 网络请求 */
- (void)wxm_initRequestCommand {
    @weakify(self);
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        /** 缓存Signal */
        if ([input isKindOfClass:[NSString class]] && [input isEqualToString:WXM_CacheSignal]) {
            return [self_weak_ wxm_cacheDataSourceRACSignal];
        }
        
        /** 刷新Signal*/
        WXMRefreshType refreshType = [input integerValue];
        if (refreshType == WXMRefreshHeaderControl) [self_weak_ wxm_pullRefreshHeaderControl];
        if (refreshType == WXMRefreshFootControl) [self_weak_ wxm_pullRefreshFootControl];
        return [self_weak_ wxm_requestDataSourceRACSignal];
    }];
}

/** 缓存信号 */
- (RACSignal *)wxm_cacheDataSourceRACSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(WXMRequestTypeLoadCache)];
        [subscriber sendCompleted];
        return nil;
    }];
}

/** 网络请求信号 子类需重写 */
- (RACSignal *)wxm_requestDataSourceRACSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(WXMRequestTypeSuccess)];
        [subscriber sendCompleted];
        return nil;
    }];
}

/** 头部刷新 */
- (void)wxm_pullRefreshHeaderControl {
    if (self.refreshType == WXMRefreshHeaderControl) return;
    self.refreshType = WXMRefreshHeaderControl;
    self.lastPage = self.currentPage = 1;
    self.isRequestting = YES;
}

/** 尾部加载 */
- (void)wxm_pullRefreshFootControl {
    if (self.refreshType == WXMRefreshFootControl ||
        self.refreshType == WXMRefreshHeaderControl) return;
    self.refreshType = WXMRefreshFootControl;
    self.currentPage += 1;
    self.isRequestting = YES;
}

/** 请求成功 */
- (void)wxm_pullRefreshSuccess {
    if (self.refreshType == WXMRefreshFootControl) self.lastPage = self.currentPage;
    if (self.refreshType != WXMRefreshFootControl) self.lastPage = self.currentPage = 1;
    self.refreshType = WXMRefreshFreedom;
    self.isRequestting = NO;
}

/** 请求失败 */
- (void)wxm_pullRefreshFail {
    if (self.refreshType == WXMRefreshFootControl) self.currentPage = self.lastPage;
    if (self.refreshType != WXMRefreshFootControl) self.lastPage = self.currentPage = 1;
    self.refreshType = WXMRefreshFreedom;
    self.isRequestting = NO;
}

/** 设置监听者 用_dataSource = @[].mutableCopy 监听者会消失 */
- (void)wxm_resetdataSourceObserver {
    if (![self.dataSource isKindOfClass:NSMutableArray.class]) {
        self.dataSource = self.dataSource.mutableCopy;
    }
    
    if ([self.dataSource respondsToSelector:@selector(wxm_setObserver:selector:)]) {
        [self.dataSource wxm_setObserver:self selector:@selector(dataSource)];
    }
}

/** 监听dataSource地址变化 dataSource地址变化后给他重新设置监听者 */
- (void)wxm_listeningdataSourceObserver {
    @weakify(self);
    [RACObserve(self, dataSource)  subscribeNext:^(id _Nullable x) {
        [self_weak_ wxm_resetdataSourceObserver];
    }];
}

- (void)dealloc {
    NSLog(@"%@ 释放 ",NSStringFromClass(self.class));
}
@end
