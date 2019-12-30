//
//  WXMBaseViewController.m
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//
#import <objc/runtime.h>
#import "WXMBaseViewController.h"

static char wxmLine;
@interface WXMBaseViewController ()
@property(readwrite, nonatomic) UIStatusBarStyle lastStatusBarStyle;
@end

@implementation WXMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeSameInterface];
    [self initializeDefaultInterface];
    self.navigationController.navigationBar.translucent = YES;
    if (@available(iOS 11.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

/**子类重写 */
- (void)initializeDefaultInterface {}
- (void)initializeSameInterface {
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.viewControllers.firstObject &&
        [self.navigationController.viewControllers.firstObject isKindOfClass:self.class] &&
        self.navigationController.viewControllers.count == 1) {
        NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:16.5],
                                      NSForegroundColorAttributeName : [UIColor whiteColor] };
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        [self.navigationController.navigationBar setTitleTextAttributes:attributes];
        
        /** 线条  */
        CALayer *line = [CALayer layer];
        line.backgroundColor = [UIColor blackColor].CGColor;
        line.frame = CGRectMake(0, 44, WXMBase_Width, 0.5);
        [self.navigationController.navigationBar.layer addSublayer:line];
        objc_setAssociatedObject(self.navigationController, &wxmLine, line, 1);
        /** [self.navigationController yd_setNavigationBarColor:YDO_navigationBarColor() alpha:1]; */
    }
}

/** 导航栏线条 */
- (void)setHiddenNavigationLine:(BOOL)hiddenNavigationLine {
    _hiddenNavigationLine = hiddenNavigationLine;
    CALayer *line = objc_getAssociatedObject(self.navigationController, &wxmLine);
    if (line) line.hidden = hiddenNavigationLine;
}

- (UIStatusBarStyle)statusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)interactivePop {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.lastStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    [UIApplication sharedApplication].statusBarStyle = self.statusBarStyle;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.transitions = YES;
    [UIApplication sharedApplication].statusBarStyle = self.lastStatusBarStyle;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.transitions = NO;
    if (self.navigationController.viewControllers.firstObject &&
        [self.navigationController.viewControllers.firstObject isKindOfClass:[self class]] &&
        self.navigationController.viewControllers.count == 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = self.interactivePop;
    }
    
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW,(1.0 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.loaded = YES;
    });
}

/** TableView */
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:WXMBase_Rect];
        _tableView.rowHeight = 49;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor redColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"defoCell"];
    }
    return _tableView;
}

/** 分组模式 */
- (UITableView *)tableViewGrouped {
    _tableView = nil;
    _tableView = [[UITableView alloc] initWithFrame:WXMBase_Rect style:UITableViewStyleGrouped];
    _tableView.rowHeight = 44;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor redColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,CGFLOAT_MIN)];
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"defoCell"];
    return _tableView;
}

/** ScrollView */
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:WXMBase_Rect];
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath*)index {
    return [table dequeueReusableCellWithIdentifier:@"defoCell"];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.scrollView endEditing:YES];
}

- (__kindof WXMBaseNetworkViewModel *)networkViewModel {
    if (!_networkViewModel) {
        _networkViewModel = [WXMBaseNetworkViewModel networkWithController:self];
    }
    return _networkViewModel;
}

- (__kindof WXMBaseTableViewModel *)tableViewViewModel {
    if (!_tableViewViewModel) {
        _tableViewViewModel = [WXMBaseTableViewModel tableVieWithController:self];
    }
    return _tableViewViewModel;
}

/** dataSource */
- (NSMutableArray *)dataSource {
    if (!_dataSource) _dataSource = @[].mutableCopy;
    return _dataSource;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
