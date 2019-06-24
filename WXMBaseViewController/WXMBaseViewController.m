//
//  WXMBaseViewController.m
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//
#import <objc/runtime.h>
#import "WXMBaseViewController.h"

static char wxm_line;
@interface WXMBaseViewController ()
@property(readwrite, nonatomic) UIStatusBarStyle lastStatusBarStyle;
@end

@implementation WXMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wxm_setupSameInterface];
    [self wxm_setupCustomInterface];
    self.navigationController.navigationBar.translucent = YES;
    if (@available(iOS 11.0, *)) {
    /** self.automaticallyAdjustsScrollViewInsets = NO; */
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

/**子类重写 */
- (void)wxm_setupCustomInterface {}
- (void)wxm_setupSameInterface {
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
        line.frame = CGRectMake(0, 44,[UIScreen mainScreen].bounds.size.width, 0.5);
        [self.navigationController.navigationBar.layer addSublayer:line];
        objc_setAssociatedObject(self.navigationController, &wxm_line, line, 1);
        /** [self.navigationController yd_setNavigationBarColor:YDO_navigationBarColor() alpha:1]; */
    }
}

/** 导航栏线条 */
- (void)setHiddenNavigationLine:(BOOL)hiddenNavigationLine {
    _hiddenNavigationLine = hiddenNavigationLine;
    CALayer *line = objc_getAssociatedObject(self.navigationController, &wxm_line);
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
    } else self.navigationController.interactivePopGestureRecognizer.enabled = self.interactivePop;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loaded = YES;
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** dataSource */
- (NSMutableArray *)dataSource {
    if (!_dataSource) _dataSource = @[].mutableCopy;
    return _dataSource;
}

/** TableView */
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:WXMBase_Rect];
        _mainTableView.rowHeight = 49;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.separatorColor = [UIColor redColor];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        [_mainTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"defoCell"];
    }
    return _mainTableView;
}

/** 分组模式 */
- (UITableView *)mainTableViewGrouped {
    _mainTableView = nil;
    _mainTableView = [[UITableView alloc] initWithFrame:WXMBase_Rect style:UITableViewStyleGrouped];
    _mainTableView.rowHeight = 44;
    _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _mainTableView.tableFooterView = [UIView new];
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.separatorColor = [UIColor redColor];
    _mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,CGFLOAT_MIN)];
    [_mainTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"defoCell"];
    return _mainTableView;
}


/** ScrollView */
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:WXMBase_Rect];
        _mainScrollView.alwaysBounceVertical = YES;
        _mainScrollView.alwaysBounceHorizontal = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)index {
    return [tableView dequeueReusableCellWithIdentifier:@"defoCell"];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.mainScrollView endEditing:YES];
}


- (__kindof WXMBaseNetworkViewModel *)networkViewModel {
    if (!_networkViewModel) {
        _networkViewModel = [WXMBaseNetworkViewModel wxm_networkWithViewController:self];
    }
    return _networkViewModel;
}

- (__kindof WXMBaseTableViewModel *)tableViewViewModel {
    if (!_tableViewViewModel) {
        _tableViewViewModel = [WXMBaseTableViewModel wxm_tableVieWithViewController:self];
    }
    return _tableViewViewModel;
}
@end
