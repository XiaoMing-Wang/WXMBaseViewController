//
//  WXMBaseViewController.m
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//

#import "WXMBaseViewController.h"

@interface WXMBaseViewController ()
@property (readwrite, nonatomic) UIStatusBarStyle lastStatusBarStyle;
@end

@implementation WXMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        //self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
/**子类重写 */
- (void)setupCustom {}
- (void)setupSameUI {
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
@end
