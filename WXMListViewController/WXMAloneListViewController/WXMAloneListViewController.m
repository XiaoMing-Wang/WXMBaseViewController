//
//  WXMAloneListViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMAloneListViewController.h"

@interface WXMAloneListViewController ()
@property(nonatomic, strong) UIView *wxm_footView;
@property(nonatomic, assign) BOOL wxm_listGrouped;
@end

@implementation WXMAloneListViewController
@synthesize mainTableView = _mainTableView;
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
- (void)wxm_pullRefreshHeaderControl {
    if (self.refreshType == WXMRefreshHeaderControl) return;
    self.refreshType = WXMRefreshHeaderControl;
    self.lastPage = self.currentPage = 1;
    self.isRequestting = YES;
}

/** 尾部加载 */
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

/** 结束刷新 */
- (void)wxm_endRefreshControl {
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1f * NSEC_PER_SEC)),queue, ^{
        self.mainTableView.mj_footer.hidden = (self.dataSource.count == 0);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), queue, ^{
        self.mainTableView.scrollEnabled = YES;
    });
}

/** 缺省图 */
- (void)wxm_setDefaultInterface:(WXMRequestType)type {
    if (self.refreshType == WXMRefreshFootControl) {
        self.mainTableView.mj_footer.hidden = NO;
        [self.mainTableView showErrorStatusViewWithType:WXMErrorStatusTypeNormal];
        return;
    }
    
    /** 全屏 */
    if (self.errorType == WXMErrorType_full) {
        WXMErrorStatusType types = WXMErrorStatusTypeNormal;
        if (self.dataSource.count == 0) types = WXMErrorStatusTypeNorecord;
        if (self.dataSource.count == 0 && type != WXMRequestTypeSuccess){
            types = WXMErrorStatusTypeRequestFail;
        }
        [self.mainTableView showErrorStatusViewWithType:types];
        self.mainTableView.mj_footer.hidden = (self.dataSource.count == 0);
    }
    
    /** 半屏 */
    if (self.errorType == WXMErrorType_foot) {
        if (self.dataSource.count > 0) self.mainTableView.tableFooterView = [UIView new];
        if (self.dataSource.count == 0) {
            WXMErrorStatusType types = WXMErrorStatusTypeNorecord;
            if (type != WXMRequestTypeSuccess) types = WXMErrorStatusTypeRequestFail;
            [self.wxm_footView showErrorStatusViewWithType:types];
            self.mainTableView.tableFooterView = self.wxm_footView;
        }
    }
}
@end
