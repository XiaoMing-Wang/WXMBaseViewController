//
//  WXMBaseListViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import "WXMMJDIYHeader.h"
#import "WXMBaseViewController.h"
#import "WXMBaseNetworkViewModel.h"

/** 错误界面大小类型 */
typedef NS_ENUM(NSUInteger, WXMErrorType) {
    WXMErrorType_fullControl = 0, /** 全屏 */
    WXMErrorType_footControl = 1, /** tableFootView */
};

@interface WXMBaseListViewController : WXMBaseViewController<WXMBaseErrorViewProtocol>

/** 异常显示默认full */
@property (nonatomic, assign) WXMErrorType errorType;

/** tableView */
@property(nonatomic, strong, readwrite) UITableView *mainTableView;

/** viewmodel */
@property (nonatomic, strong) WXMBaseNetworkViewModel *networkViewModel;

/** 刷新控件 */
@property (nonatomic, strong) WXMMJDIYHeader *listHeaderControl;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *listFootControl;

/** 切换成分组模式 */
- (UITableView *)mainTableViewGrouped;

/** 刷新 */
- (void)wxm_pullRefreshHeaderControl;
- (void)wxm_pullRefreshFootControl;
- (void)wxm_endRefreshControl;

/** 显示菊花 */
- (void)wxm_showLoadingWithContentView;
- (void)wxm_hiddenLoadingWithContentView;

/** rac */
- (void)wxm_initializeRacRequest;
- (void)wxm_setDefaultInterface:(WXMRequestType)type;

/** viewmodel的缓存代理回调 */
- (NSArray *)wxm_networkWithDataSourceCache;
@end
