//
//  WXMBaseViewController.m
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//
#import <objc/runtime.h>
#import "WXMBaseViewController.h"
#import "TMDLoginhandler.h"

@interface WXMBaseViewController ()
@property (readwrite, nonatomic) UIStatusBarStyle lastStatusBarStyle;
@end

/** 颜色画图 */
static inline UIImage *kBaseColorConversionImage(UIColor *color) {
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
    if (@available(iOS 11.0, *)) self.automaticallyAdjustsScrollViewInsets = NO;
}

/** 公共设置 */
- (void)initializeSameInterface {
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.viewControllers.firstObject &&
        self.navigationController.viewControllers.firstObject == self &&
        self.navigationController.viewControllers.count == 1) {
        UIFont *font = [UIFont systemFontOfSize:17];
        UIColor *color = kNavigationTitleColor();
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : color };
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
        [self.navigationController.navigationBar setTitleTextAttributes:attributes];
        [self setNavigationBarColor:kNavigationColor() alpha:1];
    }
}

/** 子类自定义 */
- (void)initializeDefaultInterface {
    
}

/** 设置导航栏透明 */
- (void)setNavigationBarColor:(UIColor *)color alpha:(CGFloat)alpha {
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    UIImage *image = kBaseColorConversionImage([color colorWithAlphaComponent:alpha]);
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:0];
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
    
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW,(0.75 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.loaded = YES;
    });
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:WXMBase_Rect];
        _tableView.rowHeight = 49;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor lightGrayColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (UITableView *)tableViewGrouped {
    _tableView = nil;
    _tableView = [[UITableView alloc] initWithFrame:WXMBase_Rect style:UITableViewStyleGrouped];
    _tableView.rowHeight = 49;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor lightGrayColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,CGFLOAT_MIN)];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:WXMBase_Rect];
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) _dataSource = @[].mutableCopy;
    return _dataSource;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


