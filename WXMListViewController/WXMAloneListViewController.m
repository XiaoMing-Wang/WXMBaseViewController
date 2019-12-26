//
//  WXMAloneListViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMAloneListViewController.h"

@interface WXMAloneListViewController ()
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, assign) BOOL listGrouped;
@end

@implementation WXMAloneListViewController
@synthesize tableView = _tableView;
@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastPage = 1;
    self.currentPage = 1;
    self.isRequestting = NO;
    self.dataSource = @[].mutableCopy;
    self.refreshType = WXMRefreshFreedom;
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

- (NSMutableArray *)currentDataSoure {
    return self.dataSource;
}
@end
