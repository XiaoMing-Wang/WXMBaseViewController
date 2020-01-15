//
//  WXMBaseViewController.m
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//
#import <objc/runtime.h>
#import "WXMBaseViewController.h"

@interface WXMBaseViewController ()
@property (readwrite, nonatomic) UIStatusBarStyle lastStatusBarStyle;
@end

/** 颜色画图 */
static inline UIImage *WXM_baseColorConversionImage(UIColor *color) {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

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
- (void)initializeDefaultInterface { }

- (void)initializeSameInterface {
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.viewControllers.firstObject &&
        [self.navigationController.viewControllers.firstObject isKindOfClass:self.class] &&
        self.navigationController.viewControllers.count == 1) {
        NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:17],
                                      NSForegroundColorAttributeName : WXM_navigationTitleColor() };
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        [self.navigationController.navigationBar setTitleTextAttributes:attributes];
        
        /** 线条  */
        CALayer *line = [CALayer layer];
        line.backgroundColor = [UIColor blackColor].CGColor;
        line.frame = CGRectMake(0, 44, WXMBase_Width, 0.5);
        [self.navigationController.navigationBar.layer addSublayer:line];
        objc_setAssociatedObject(self.navigationController, @"navigation_line", line, 1);
        
        [self setHiddenNavigationLine:YES];
        [self setNavigationBarColor:WXM_navigationColor() alpha:1];
    }
}

/** 设置导航栏透明 */
- (void)setNavigationBarColor:(UIColor *)color alpha:(CGFloat)alpha {
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    color = [color colorWithAlphaComponent:alpha];
    UIImage *image = WXM_baseColorConversionImage(color);
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

/** 导航栏线条 */
- (void)setHiddenNavigationLine:(BOOL)hiddenNavigationLine {
    _hiddenNavigationLine = hiddenNavigationLine;
    CALayer *line = objc_getAssociatedObject(self.navigationController, @"navigation_line");
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
    }
    return _tableView;
}

/** 分组模式 */
- (UITableView *)tableViewGrouped {
    _tableView = nil;
    _tableView = [[UITableView alloc] initWithFrame:WXMBase_Rect style:UITableViewStyleGrouped];
    _tableView.rowHeight = 49;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor redColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,CGFLOAT_MIN)];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView endEditing:YES];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (__kindof WXMBaseTableViewModel *)tableViewViewModel {
    if (!_tableViewViewModel) {
        SEL sel = @selector(tableVieWithController:);
        _tableViewViewModel = [self.tableViewViewModelClass performSelector:sel withObject:self];
    }
    return _tableViewViewModel;
}

- (__kindof WXMBaseNetworkViewModel *)networkViewModel {
    if (!_networkViewModel) {
        SEL sel = @selector(networkWithController:);
        _networkViewModel = [self.tableViewViewModelClass performSelector:sel withObject:self];
    }
    return _networkViewModel;
}

/** viewmodel类 */
- (Class)tableViewViewModelClass {
    return WXMBaseTableViewModel.class;
}

/** network类 */
- (Class)networkViewModelClass {
    return WXMBaseNetworkViewModel.class;
}

/** 子类覆盖该方法强制转换 */
- (__kindof WXMBaseNetworkViewModel *)currentNetwork {
    return (WXMBaseNetworkViewModel *) self.networkViewModel;
}

#pragma clang diagnostic pop

/** dataSource */
- (NSMutableArray *)dataSource {
    if (!_dataSource) _dataSource = @[].mutableCopy;
    return _dataSource;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


