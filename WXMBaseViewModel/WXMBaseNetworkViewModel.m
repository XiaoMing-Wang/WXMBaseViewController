//
//  WXMBaseNetworkViewModel.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseNetworkViewModel.h"
@interface WXMBaseNetworkViewModel ()
@property(nonatomic, weak, readwrite) UIViewController <WXMNetworkViewModelProtocol>*viewController;
@end
@implementation WXMBaseNetworkViewModel

+ (instancetype)wxm_networkWithViewController:(UIViewController<WXMNetworkViewModelProtocol>*)controller {
    WXMBaseNetworkViewModel *networkViewModel = [[self alloc] initWithController:controller];
    return networkViewModel;
}
- (instancetype)initWithController:(UIViewController<WXMNetworkViewModelProtocol>*)viewController {
    if (self = [super init]) {
       
        _lastPage = 1;
        _currentPage = 1;
        _isRequestting = NO;
        _dataSource = @[].mutableCopy;
        _refreshType = WXMRefreshFreedom;
        _viewController = viewController;
        _existCache = [self wxm_subclassCacheType];
        [self wxm_initRequestCommand];
    }
    return self;
}

/** 缓存 */
- (WXMExistCacheType)wxm_subclassCacheType {
    _existCache = WXMExistCacheTypeNone;
    if (_viewController && [_viewController respondsToSelector:@selector(wxm_networkWithDataSourceCache)]) {
        NSArray * cacheArray = [_viewController wxm_networkWithDataSourceCache];
        if (cacheArray.count > 0) _existCache = WXMExistCacheTypeExistCache;
        [self.dataSource addObjectsFromArray:cacheArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.requestCommand execute:@(WXMRefreshHeaderControl)];
        });
    }
    return _existCache;
}

/** 网络请求 */
- (void)wxm_initRequestCommand {
    
    __weak __typeof(self) weakself = self;
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        WXMRefreshType refreshType = [input integerValue];
        if (refreshType == WXMRefreshHeaderControl || !input) [weakself wxm_pullRefreshHeaderControl];
        if (refreshType == WXMRefreshFootControl) [weakself wxm_pullRefreshFootControl];
        return [weakself wxm_requestDataSourceRACSignal];
    }];
    
}

/** 子类重写 */
- (RACSignal *)wxm_requestDataSourceRACSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:nil];
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

/** 尾部记载 */
- (void)wxm_pullRefreshFootControl {
    if (self.refreshType == WXMRefreshFootControl || self.refreshType == WXMRefreshHeaderControl) return;
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
@end
