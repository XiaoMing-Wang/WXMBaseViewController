//
//  WXMBaseNetworkViewModel.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#define WXM_CacheSignal @"WXM_CacheSignal"
#import "WXMBaseNetworkAssist.h"
@interface WXMBaseNetworkAssist ()
@property(nonatomic, weak, readwrite) UIViewController *controller;
@end
@implementation WXMBaseNetworkAssist

+ (instancetype)networkWithController:(UIViewController *)controller {
    WXMBaseNetworkAssist *networkViewModel = [[self alloc] initWithController:controller];
    return networkViewModel;
}

- (instancetype)initWithController:(UIViewController *)controller {
    if (self = [super init]) {
        _lastPage = 1;
        _currentPage = 1;
        _isRequestting = NO;
        _dataSource = @[].mutableCopy;
        _refreshType = WXMRefreshFreedom;
        _controller = controller;
        _existCache = [self subclassCacheType];
        [_dataSource wxm_setObserver:self selector:@selector(dataSource)];
    }
    return self;
}

/** 由controller回调缓存 */
- (WXMExistCacheType)subclassCacheType {
    _existCache = WXMExistCacheTypeNone;
    return _existCache;
}

/** 头部刷新 */
- (void)pullRefreshHeaderControl {
    if (self.refreshType == WXMRefreshHeaderControl) return;
    self.refreshType = WXMRefreshHeaderControl;
    self.lastPage = self.currentPage = 1;
    self.isRequestting = YES;
}

/** 尾部加载 */
- (void)pullRefreshFootControl {
    if (self.refreshType == WXMRefreshFootControl ||
        self.refreshType == WXMRefreshHeaderControl) return;
    self.refreshType = WXMRefreshFootControl;
    self.currentPage += 1;
    self.isRequestting = YES;
}

/** 请求成功 */
- (void)pullRefreshSuccess {
    if (self.refreshType == WXMRefreshFootControl) self.lastPage = self.currentPage;
    if (self.refreshType != WXMRefreshFootControl) self.lastPage = self.currentPage = 1;
    self.refreshType = WXMRefreshFreedom;
    self.isRequestting = NO;
}

/** 请求失败 */
- (void)pullRefreshFail {
    if (self.refreshType == WXMRefreshFootControl) self.currentPage = self.lastPage;
    if (self.refreshType != WXMRefreshFootControl) self.lastPage = self.currentPage = 1;
    self.refreshType = WXMRefreshFreedom;
    self.isRequestting = NO;
}

/** 设置监听者 用_dataSource = @[].mutableCopy 监听者会消失 */
- (void)resetdataSourceObserver {
    if (![self.dataSource isKindOfClass:NSMutableArray.class]) {
        self.dataSource = self.dataSource.mutableCopy;
    }
    
    if ([self.dataSource respondsToSelector:@selector(wxm_setObserver:selector:)]) {
        [self.dataSource wxm_setObserver:self selector:@selector(dataSource)];
    }
}

- (void)dealloc {
    NSLog(@"%@ 释放 ",NSStringFromClass(self.class));
}
@end
