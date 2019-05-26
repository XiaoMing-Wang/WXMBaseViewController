//
//  WXMAloneListViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import "WXMMJDIYHeader.h"
#import "WXMBaseViewController.h"
#import "WXMBaseNetworkViewModel.h"
#import "WXMBaseViewController.h"
#import "WXMErrorStatusView.h"
#import "WXMBaseListViewController.h"
#import "UIView+WXMErrorStatusView.h"
#import "WXMBaseListViewController.h"

@interface WXMAloneListViewController : WXMBaseListViewController

@property(nonatomic, assign) NSInteger lastPage;
@property(nonatomic, assign) NSInteger currentPage;

/** tableView */
@property(nonatomic, strong, readwrite) UITableView *mainTableView;
@property(nonatomic, strong, readwrite) NSMutableArray *dataSource;

/** 是否存在缓存 */
@property(nonatomic, assign) WXMExistCacheType existCache;

/** 上下拉状态 */
@property(nonatomic, assign) WXMRefreshType refreshType;
@property(nonatomic, assign) BOOL isRequestting;

/** 切换成分组模式 */
- (void)wxm_pullRefreshSuccess;
- (void)wxm_pullRefreshFail;

@end
