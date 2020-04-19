//
//  WXMBaseNetworkhandler.m
//  WXMComponentization
//
//  Created by sdjim on 2020/4/2.
//  Copyright © 2020 sdjim. All rights reserved.
//

#import <objc/runtime.h>
#import "WXMBaseNetworkHandler.h"
#import "NSMutableArray+WXMKVOKit.h"

static char networkhandler;
@interface WXMBaseNetworkHandler ()
@property (nonatomic, weak, readwrite) id <WXMBaseNetworkHandlerProtocol>delegate;
@property (nonatomic, weak, readwrite) UIViewController <WXMBaseNetworkHandlerProtocol> *controller;
@end

IMPLEMENTATION_CLASS(WXMBaseAutomaticImpModel);
@implementation WXMBaseNetworkHandler

/** 防止宏崩溃 */
+ (void)load {
    Class class = object_getClass(self);
    SEL handleSEL = NSSelectorFromString(@"handlerImp");
    id handleIMP = ^(id dependInstance) { };
    class_addMethod(class, handleSEL, imp_implementationWithBlock(handleIMP), "v@:@");
}

/** 把handler绑定在控制器上 生命周期由控制器管理 */
/** 把handler绑定在控制器上 生命周期由控制器管理 */
/** 把handler绑定在控制器上 生命周期由控制器管理 */
+ (instancetype (^)(id delegate))singletonhandler {
    return ^(id<WXMBaseNetworkHandlerProtocol> delegate) {
        WXMBaseNetworkHandler *handlers = objc_getAssociatedObject(delegate, &networkhandler);
        if (handlers == nil) {
            handlers = [[self alloc] initWithDelegate:delegate];
            objc_setAssociatedObject(delegate, &networkhandler, handlers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return handlers;
    };
}

/** 继承WXMBaseAutomaticImpModel的属性自动初始化 model类每次都出初始化太麻烦 */
/** 继承WXMBaseAutomaticImpModel的属性自动初始化 model类每次都出初始化太麻烦 */
/** 继承WXMBaseAutomaticImpModel的属性自动初始化 model类每次都出初始化太麻烦 */
- (void)automaticInitialization {
    unsigned int methodCount = 0;
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Ivar ivar = ivars[i];
        NSString *typeString = [NSString stringWithFormat:@"%s",ivar_getTypeEncoding(ivar)];
        if (typeString.length > 3) {
            typeString = [typeString substringToIndex:typeString.length - 1];
            typeString = [typeString substringFromIndex:2];
        }
        
        Class aClass = NSClassFromString(typeString);
        NSString *supClass = NSStringFromClass([aClass superclass]);
        if ([supClass isEqualToString:@"WXMBaseAutomaticImpModel"]) {
            object_setIvar(self, ivar, [aClass new]);
        }
    }
    free(ivars);
}

- (instancetype)initWithDelegate:(id<WXMBaseNetworkHandlerProtocol>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        self.lastPage = 1;
        self.currentPage = 1;
        self.isRequestting = NO;
        self.dataSource = @[].mutableCopy;
        self.refreshType = WXMRefreshFreedom;
        [self.dataSource wxm_setObserver:self selector:@selector(dataSource)];
        if ([delegate isKindOfClass:UIViewController.class]) {
            self.controller = (UIViewController <WXMBaseNetworkHandlerProtocol> *)delegate;
        }
        
        [self automaticInitialization];
        [self initializationVariable];
    }
    return self;
}

- (void)initializationVariable {
    
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
    if (self.refreshType == WXMRefreshFootControl || self.refreshType == WXMRefreshHeaderControl) return;
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

/** 这个函数做多个接口统一处理用 单独处理用block */
- (void)callSuccessWithArray:(nullable NSArray *)arrays {
    SEL sel = @selector(wt_requestSuccessWithArray:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        return [self.delegate wt_requestSuccessWithArray:arrays];
    }
}

/** 这个函数做多个接口统一处理用 单独处理用block */
- (void)callSuccessWithEvent:(nullable NSString *)event object:(nullable id)object {
    SEL sel = @selector(wt_requestSuccessWithEvent:object:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        return [self.delegate wt_requestSuccessWithEvent:event object:object];
    }
}

/** 这个函数做多个接口统一处理用 单独处理用block */
- (void)callFailWithEvent:(nullable NSString *)event object:(nullable id)object {
    SEL sel = @selector(wt_requestFailWithEvent:object:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        return [self.delegate wt_requestFailWithEvent:event object:object];
    }
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

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self resetdataSourceObserver];
}

- (void)dealloc {
    /** NSLog(@"%@ 释放 ",NSStringFromClass(self.class)); */
}

@end

