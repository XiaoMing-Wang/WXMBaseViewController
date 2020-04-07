//
//  WXMBaseListViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import "WXMMJDIYHeader.h"
#import "WXMBaseViewController.h"
#import "WXMBaseNetworkAssist.h"

/** 错误界面大小类型 */
typedef NS_ENUM(NSUInteger, WXMErrorType) {
    
    /** 全屏 */
    WXMErrorType_fullControl = 0,
    
    /** tableFootView */
    WXMErrorType_footControl = 1,
};

@interface WXMBaseListViewController : WXMBaseViewController<WXMBaseErrorViewProtocol>

/** 异常显示默认full */
@property (nonatomic, assign) WXMErrorType errorType;

/** tableView */
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) UIView *footControl;

/** viewmodel */
@property (nonatomic, strong) WXMBaseNetworkAssist *networkViewModel;

/** 刷新控件 */
@property (nonatomic, strong) WXMMJDIYHeader *listHeaderControl;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *listFootControl;

/** 切换成分组模式 */
- (UITableView *)tableViewGrouped;

/** 刷新 */
- (void)pullRefreshHeaderControl;
- (void)pullRefreshFootControl;
- (void)endRefreshControl;
- (void)setDefaultInterface:(WXMRequestType)type;
@end
