//
//  WXMBaseListViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import "WXMErrorStatusView.h"
#import "WXMBaseListViewController.h"
#import "UIView+WXMErrorStatusView.h"

@interface WXMBaseListViewController ()
@property(nonatomic, strong) UIView *wxm_footView;
@property(nonatomic, assign) BOOL wxm_listGrouped;
@end

@implementation WXMBaseListViewController
@synthesize mainTableView = _mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
}

/** 网络请求 */
- (void)wxm_initializeRacRequest {
    [self.networkViewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSInteger code = [x integerValue];
        if (code == WXMRequestTypeSuccess) [self.mainTableView reloadData];
        [self wxm_endRefreshControl];
        [self wxm_setDefaultInterface:code];
        NSLog(@"%@",self.networkViewModel.dataSource);
    }];
}

/** 判断缓存 */
- (NSArray *)wxm_networkWithDataSourceCache {
    NSMutableArray * cacheArray = nil;
    if (!cacheArray && self.errorType == WXMErrorType_full) {
        [self.mainTableView showErrorStatusViewWithType:WXMErrorStatusTypeRequestLoading];
    } else if (!cacheArray && self.errorType == WXMErrorType_foot) {
        [self.wxm_footView showErrorStatusViewWithType:WXMErrorStatusTypeRequestLoading];
    }
    return cacheArray;
}

/** 头部刷新 */
- (void)wxm_pullRefreshHeaderControl {
    [self.networkViewModel.requestCommand execute:@(WXMRefreshHeaderControl)];
}

/** 尾部加载 */
- (void)wxm_pullRefreshFootControl {
    [self.networkViewModel.requestCommand execute:@(WXMRefreshFootControl)];
}

/** 结束刷新 */
- (void)wxm_endRefreshControl {
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1f * NSEC_PER_SEC)),queue, ^{
        self.mainTableView.mj_footer.hidden = (self.networkViewModel.dataSource.count == 0);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), queue, ^{
        self.mainTableView.scrollEnabled = YES;
    });
}

/** 缺省图 */
- (void)wxm_setDefaultInterface:(WXMRequestType)type {
     if (self.networkViewModel.refreshType == WXMRefreshFootControl) {
         self.mainTableView.mj_footer.hidden = NO;
         [self.mainTableView showErrorStatusViewWithType:WXMErrorStatusTypeNormal];
         return;
     }
   
    /** 全屏 */
    if (self.errorType == WXMErrorType_full) {
        WXMErrorStatusType types = WXMErrorStatusTypeNormal;
        if (self.networkViewModel.dataSource.count == 0) types = WXMErrorStatusTypeNorecord;
        if (self.networkViewModel.dataSource.count == 0 && type != WXMRequestTypeSuccess){
            types = WXMErrorStatusTypeRequestFail;
        }
        [self.mainTableView showErrorStatusViewWithType:types];
        self.mainTableView.mj_footer.hidden = (self.networkViewModel.dataSource.count == 0);
    }
    
    /** 半屏 */
    if (self.errorType == WXMErrorType_foot) {
        if (self.networkViewModel.dataSource.count > 0) self.mainTableView.tableFooterView = [UIView new];
        if (self.networkViewModel.dataSource.count == 0) {
            WXMErrorStatusType types = WXMErrorStatusTypeNorecord;
            if (type != WXMRequestTypeSuccess) types = WXMErrorStatusTypeRequestFail;
            [self.wxm_footView showErrorStatusViewWithType:types];
            self.mainTableView.tableFooterView = self.wxm_footView;
        }
    }
}

/** errorType */
- (void)setErrorType:(WXMErrorType)errorType {
    _errorType = errorType;
    if (errorType == WXMErrorType_foot) {
        CGFloat headerHeight = self.mainTableView.tableHeaderView.frame.size.height;
        CGFloat footHeight = self.mainTableView.frame.size.height - headerHeight;
        WXMErrorStatusView *erorr = [WXMErrorStatusView wxm_errorsViewWithType:WXMErrorStatusTypeNorecord];
        CGFloat realH = MAX(footHeight, erorr.minHeight);
        self.wxm_footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WXMBase_Width, realH)];
        self.wxm_footView.backgroundColor = [UIColor greenColor];
        self.mainTableView.tableFooterView = self.wxm_footView;
    }
}

#pragma mark -------------------------------- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_wxm_listGrouped) return self.networkViewModel.dataSource.count;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_wxm_listGrouped) return 1;
    return self.networkViewModel.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * iden = NSStringFromClass(self.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -------------------------------- lazy

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        CGRect rect = CGRectMake(0, WXMBase_BarHeight, WXMBase_Width, WXMBase_Height - WXMBase_BarHeight);
        NSString * iden = NSStringFromClass(self.class);
        _mainTableView = [[UITableView alloc] initWithFrame:rect];
        _mainTableView.rowHeight = 49;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [_mainTableView registerClass:UITableViewCell.class forCellReuseIdentifier:iden];
    }
    return _mainTableView;
}

- (UITableView *)mainTableViewGrouped {
    if (!_mainTableView) {
        NSString * iden = NSStringFromClass(self.class);
        CGRect rect = CGRectMake(0, WXMBase_BarHeight, WXMBase_Width, WXMBase_Height - WXMBase_BarHeight);
        _mainTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _mainTableView.rowHeight = 49;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [_mainTableView registerClass:UITableViewCell.class forCellReuseIdentifier:iden];
    }
    return _mainTableView;
}
- (WXMMJDIYHeader *)listHeaderControl {
    if (!_listHeaderControl) {
        SEL sel = NSSelectorFromString(@"wxm_pullRefreshHeaderControl");
        _listHeaderControl = [WXMMJDIYHeader headerWithRefreshingTarget:self refreshingAction:sel];
    }
    return _listHeaderControl;
}
- (MJRefreshAutoNormalFooter *)listFootControl {
    if (!_listFootControl) {
        SEL sel = NSSelectorFromString(@"wxm_pullRefreshFootControl");
        _listFootControl = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:sel];
        _listFootControl.hidden = YES;
    }
    return _listFootControl;
}
- (__kindof WXMBaseNetworkViewModel *)networkViewModel {
    if (!_networkViewModel) _networkViewModel = [WXMBaseNetworkViewModel wxm_networkWithViewController:self];
    return _networkViewModel;
}
@end
