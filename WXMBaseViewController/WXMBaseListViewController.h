//
//  WXMAloneListViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import "WXMMJDIYHeader.h"
#import "WXMBaseViewController.h"
#import "WXMBaseNetworkhandler.h"
#import "WXMBaseViewController.h"
#import "WXMBaseListViewController.h"

/** 不用viewmoderl的父类 */
@interface WXMBaseListViewController : WXMBaseViewController

@property (nonatomic, assign, readwrite) NSInteger lastPage;
@property (nonatomic, assign, readwrite) NSInteger currentPage;

/** tableView */
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSMutableArray *dataSource;

@property (nonatomic, strong) WXMMJDIYHeader *listHeaderControl;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *listFootControl;

/** 刷新状态 */
@property (nonatomic, assign) WXMRefreshType refreshType;
@property (nonatomic, assign) BOOL isRequestting;

- (void)pullRefreshHeaderControl;
- (void)pullRefreshFootControl;
- (void)pullRefreshSuccess;
- (void)pullRefreshFail;

- (void)endRefreshControl;
- (void)endRefreshControlNoMoreData;

@end
