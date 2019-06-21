//
//  WXMBaseViewController.m
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//

#import "WXMBaseViewController.h"

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
    }
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
    }
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
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
@end
