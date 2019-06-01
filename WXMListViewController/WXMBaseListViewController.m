//
//  WXMBaseListViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import "WXMBaseListViewController.h"

@interface WXMBaseListViewController ()
@property(nonatomic, assign) BOOL wxm_listGrouped;
@property(nonatomic, strong) UIView *wxm_footControl;
@end

@implementation WXMBaseListViewController
@synthesize mainTableView = _mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
}

/** 子类需要调用这个方法 初始化回调 Command*/
/** 回调 Command初始化  */
- (void)wxm_initializeRacRequest {
    [self.networkViewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"刷新TableView");
        WXMRequestType errorCode = [x integerValue];
        if (errorCode == WXMRequestTypeSuccess || errorCode == WXMRequestTypeLoadCache)  {
            [self.mainTableView reloadData];
        }
        [self wxm_endRefreshControl];
        [self wxm_setDefaultInterface:errorCode];
    }];
}

/** 判断缓存 */
- (NSArray *)wxm_networkWithDataSourceCache {
    NSMutableArray * cacheArray = nil;
    if (cacheArray.count == 0 || !cacheArray) [self wxm_showLoadingWithContentView];
    return cacheArray;
}

/** 显示菊花 */
- (void)wxm_showLoadingWithContentView {
    UIView * supView = _errorType ? self.wxm_footControl : self.mainTableView;
    if ([self respondsToSelector:@selector(wxm_showloadingWithSupView:)]) {
        [self wxm_showloadingWithSupView:supView];
    }
}
- (void)wxm_hiddenLoadingWithContentView {
    if ([self respondsToSelector:@selector(wxm_hiddenLoadingView)]) {
        [self wxm_hiddenLoadingView];
    }
}

/** 头部刷新 */
- (void)wxm_pullRefreshHeaderControl {
    self.mainTableView.scrollEnabled = NO;
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.27f * NSEC_PER_SEC)),queue, ^{
        self.mainTableView.mj_footer.hidden = (self.currentDataSoure.count == 0);
        self.mainTableView.scrollEnabled = YES;
    });
}

/** 缺省图 */
- (void)wxm_setDefaultInterface:(WXMRequestType)requestResult {
    [self wxm_hiddenLoadingWithContentView];
    
    /** footView */
    BOOL impleShow = [self respondsToSelector:@selector(wxm_showErrorView:protocolType:)];
    BOOL impRemove = [self respondsToSelector:@selector(wxm_removeErrorView)];
    if (self.networkViewModel.refreshType == WXMRefreshFootControl) {
        self.mainTableView.mj_footer.hidden = NO;
        if (impRemove) [self wxm_removeErrorView];
        return;
    }

    /** header */
    UIView * supView = self.mainTableView;
    WXMErrorStatusProtocolType errTy = WXMErrorProtocolTypeNormal;
    self.mainTableView.mj_footer.hidden = (self.networkViewModel.dataSource.count == 0);
    if (self.currentDataSoure.count == 0) errTy = WXMErrorProtocolTypeNorecord;
    if (self.currentDataSoure.count == 0 &&
        (requestResult == WXMRequestTypeErrorCode || requestResult == WXMRequestTypeFail)){
        errTy = WXMErrorProtocolTypeRequestFail;
    }
    
    if (self.errorType == WXMErrorType_footControl) {
        self.mainTableView.tableFooterView = self.wxm_footControl;
        supView = self.wxm_footControl;
    }
    if (impleShow) [self wxm_showErrorView:supView protocolType:errTy];
}

/** 设置errorType */
- (void)setErrorType:(WXMErrorType)errorType {
    _errorType = errorType;
    if (errorType == WXMErrorType_footControl) {
        CGFloat errorControlH = 0;
        if ([self respondsToSelector:@selector(wxm_errorControlMinHeight)]) {
            errorControlH = self.wxm_errorControlMinHeight;
        }
        
        CGFloat headerHeight = self.mainTableView.tableHeaderView.frame.size.height;
        CGFloat footHeight = self.mainTableView.frame.size.height - headerHeight;
        CGFloat realH = MAX(errorControlH, footHeight);
        self.wxm_footControl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WXMBase_Width, realH)];
        self.wxm_footControl.backgroundColor = [UIColor redColor];
        self.mainTableView.tableFooterView = self.wxm_footControl;
    }
}

#pragma mark -------------------------------- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_wxm_listGrouped) return self.currentDataSoure.count;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_wxm_listGrouped) return 1;
    return self.currentDataSoure.count;
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
        CGRect rect = {0, WXMBase_BarHeight, WXMBase_Width, WXMBase_Height - WXMBase_BarHeight};
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
        CGRect rect = {0, WXMBase_BarHeight, WXMBase_Width, WXMBase_Height - WXMBase_BarHeight};
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

- (NSMutableArray *)currentDataSoure {
    return self.networkViewModel.dataSource;
}
@end
