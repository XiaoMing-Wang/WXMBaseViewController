//
//  WXMAloneListViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseListViewController.h"

@interface WXMBaseListViewController ()
@property (nonatomic, assign, readwrite) NSInteger lastDataCount;
@end

@implementation WXMBaseListViewController
@synthesize tableView = _tableView;
@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastPage = 1;
    self.currentPage = 1;
    self.isRequestting = NO;
    self.dataSource = @[].mutableCopy;
    self.refreshType = WXMRefreshFreedom;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

/** 头部刷新 */
- (void)pullRefreshHeaderControl {
    if (self.refreshType == WXMRefreshHeaderControl) return;
    self.refreshType = WXMRefreshHeaderControl;
    self.lastPage = self.currentPage = 1;
    self.isRequestting = YES;
    self.tableView.scrollEnabled = NO;
}

/** 尾部加载 */
- (void)pullRefreshFootControl {
    if (self.refreshType == WXMRefreshFootControl || self.refreshType == WXMRefreshHeaderControl) return;
    self.refreshType = WXMRefreshFootControl;
    self.currentPage += 1;
    self.isRequestting = YES;
}

/** 结束刷新 */
- (void)endRefreshControl {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    BOOL nodatas = (self.currentDataSoure.count == self.lastDataCount && self.lastDataCount);
    if (self.refreshType == WXMRefreshHeaderControl) {
        
        self.tableView.mj_footer.hidden = (self.currentDataSoure.count == 0);
        
    } else if (self.refreshType == WXMRefreshFootControl && nodatas) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    self.lastDataCount = self.currentDataSoure.count;
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.27f * NSEC_PER_SEC)),queue, ^{
        self.tableView.scrollEnabled = YES;
    });
}

- (void)endRefreshControlNoMoreData {
    [self endRefreshControl];
    self.tableView.mj_footer.hidden = NO;
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

/** 请求成功 */
- (void)pullRefreshSuccess {
    if (self.refreshType == WXMRefreshFootControl) self.lastPage = self.currentPage;
    if (self.refreshType != WXMRefreshFootControl) self.lastPage = self.currentPage = 1;
    self.refreshType = WXMRefreshFreedom;
    self.isRequestting = NO;
    [self endRefreshControl];
}

/** 请求失败 */
- (void)pullRefreshFail {
    if (self.refreshType == WXMRefreshFootControl) self.currentPage = self.lastPage;
    if (self.refreshType != WXMRefreshFootControl) self.lastPage = self.currentPage = 1;
    self.refreshType = WXMRefreshFreedom;
    self.isRequestting = NO;
    [self endRefreshControl];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSMutableArray *)currentDataSoure {
    return self.dataSource;
}

- (WXMMJDIYHeader *)listHeaderControl {
    if (!_listHeaderControl) {
        SEL sel = @selector(pullRefreshHeaderControl);
        _listHeaderControl = [WXMMJDIYHeader headerWithRefreshingTarget:self refreshingAction:sel];
    }
    return _listHeaderControl;
}

- (MJRefreshAutoNormalFooter *)listFootControl {
    if (!_listFootControl) {
        SEL sel = @selector(pullRefreshFootControl);
        _listFootControl = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:sel];
        _listFootControl.hidden = YES;
    }
    return _listFootControl;
}

@end
