//
//  WXMBaseListViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import "WXMBaseListViewController.h"

@interface WXMBaseListViewController ()
@property(nonatomic, assign) BOOL listGrouped;
@end

@implementation WXMBaseListViewController
@synthesize tableView = _tableView;
@synthesize networkViewModel = _networkViewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

/** 显示菊花 */
- (void)showLoadingWithContentView {
    UIView * supView = _errorType ? self.footControl : self.tableView;
    if ([self respondsToSelector:@selector(showloadingWithSupView:)]) {
        [self showloadingWithSupView:supView];
    }
}

/** 隐藏菊花 */
- (void)hiddenLoadingWithContentView {
    if ([self respondsToSelector:@selector(hiddenLoadingView)]) {
        [self hiddenLoadingView];
    }
}

/** 头部刷新 */
- (void)pullRefreshHeaderControl {
    self.tableView.scrollEnabled = NO;
    [self.networkViewModel pullRefreshHeaderControl];
}

/** 尾部加载 */
- (void)pullRefreshFootControl {
    [self.networkViewModel pullRefreshFootControl];
}

/** 结束刷新 */
- (void)endRefreshControl {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.27f * NSEC_PER_SEC)),queue, ^{
        self.tableView.mj_footer.hidden = (self.currentDataSoure.count == 0);
        self.tableView.scrollEnabled = YES;
    });
}

/** 缺省图 */
- (void)setDefaultInterface:(WXMRequestType)requestResult {
    [self hiddenLoadingWithContentView];
    
    /** footView */
    BOOL impleShow = [self respondsToSelector:@selector(showErrorView:protocolType:)];
    BOOL impRemove = [self respondsToSelector:@selector(removeErrorView)];
    if (self.networkViewModel.refreshType == WXMRefreshFootControl) {
        self.tableView.mj_footer.hidden = NO;
        if (impRemove) [self removeErrorView];
        return;
    }

    /** header */
    UIView *supView = self.tableView;
    WXMErrorStatusProtocolType errTy = WXMErrorProtocolTypeNormal;
    self.tableView.mj_footer.hidden = (self.networkViewModel.dataSource.count == 0);
    if (self.currentDataSoure.count == 0) errTy = WXMErrorProtocolTypeNorecord;
    if (self.currentDataSoure.count == 0 &&
        (requestResult == WXMRequestTypeErrorCode || requestResult == WXMRequestTypeFail)){
        errTy = WXMErrorProtocolTypeRequestFail;
    }
    
    if (self.errorType == WXMErrorType_footControl) {
        self.tableView.tableFooterView = self.footControl;
        supView = self.footControl;
    }
    if (impleShow) [self showErrorView:supView protocolType:errTy];
}

/** 设置errorType */
- (void)setErrorType:(WXMErrorType)errorType {
    _errorType = errorType;
    if (errorType == WXMErrorType_footControl) {
        CGFloat errorControlH = 0;
        if ([self respondsToSelector:@selector(errorControlMinHeight)]) {
            errorControlH = self.errorControlMinHeight;
        }
        
        CGFloat headerHeight = self.tableView.tableHeaderView.frame.size.height;
        CGFloat footHeight = self.tableView.frame.size.height - headerHeight;
        CGFloat realH = MAX(errorControlH, footHeight);
        self.footControl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WXMBase_Width, realH)];
        self.footControl.backgroundColor = [UIColor redColor];
        self.tableView.tableFooterView = self.footControl;
    }
}

#pragma mark -------------------------------- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_listGrouped) return self.currentDataSoure.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_listGrouped) return 1;
    return self.currentDataSoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -------------------------------- lazy

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect rect = {0, WXMBase_BarHeight, WXMBase_Width, WXMBase_Height - WXMBase_BarHeight};
        NSString * iden = NSStringFromClass(self.class);
        _tableView = [[UITableView alloc] initWithFrame:rect];
        _tableView.rowHeight = 49;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:iden];
    }
    return _tableView;
}

- (UITableView *)tableViewGrouped {
    if (!_tableView) {
        CGRect rect = {0, WXMBase_BarHeight, WXMBase_Width, WXMBase_Height - WXMBase_BarHeight};
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.rowHeight = 49;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (WXMMJDIYHeader *)listHeaderControl {
    if (!_listHeaderControl) {
        SEL sel = @selector(pullRefreshHeaderControl);
        _listHeaderControl =
        [WXMMJDIYHeader headerWithRefreshingTarget:self refreshingAction:sel];
    }
    return _listHeaderControl;
}

- (MJRefreshAutoNormalFooter *)listFootControl {
    if (!_listFootControl) {
        SEL sel = @selector(pullRefreshFootControl);
        _listFootControl =
        [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:sel];
        _listFootControl.hidden = YES;
    }
    return _listFootControl;
}

- (__kindof WXMBaseNetworkViewModel *)networkViewModel {
    if (!_networkViewModel) {
        _networkViewModel = [WXMBaseNetworkViewModel networkWithController:self];
    }
    return _networkViewModel;
}

- (NSMutableArray *)currentDataSoure {
    return self.networkViewModel.dataSource;
}
@end
