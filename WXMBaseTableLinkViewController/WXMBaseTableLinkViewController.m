//
//  WXMBaseTableLinkViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2020/1/20.
//  Copyright © 2020 wxm. All rights reserved.
//
#define kWindow [[[UIApplication sharedApplication] delegate] window]
#define kSWidth [UIScreen mainScreen].bounds.size.width
#define kSHeight [UIScreen mainScreen].bounds.size.height
#define kEdgeRect CGRectMake(0, kNBarHeight, kSWidth, kSHeight - kNBarHeight)

/** 导航栏高度 安全高度 */
#define kNBarHeight ((kIPhoneX) ? 88.0f : 64.0f)
#define kSafeHeight ((kIPhoneX) ? 25.0f : 0.0f)

/** iphoneX */
#define kIPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);\
})

#import "WXMBaseTableLinkViewController.h"
#import "WXMBaseChildTableViewController.h"
#import "UIViewController+WXMTableSliding.h"

@interface WXMBaseTableLinkViewController ()
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIActivityIndicatorView *loading;
@end

@implementation WXMBaseTableLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.loading];
    [self.view addSubview:self.tableHeader];
    [self.view addSubview:self.rowHeader];
    
    [self addChildWithViewController:[WXMBaseChildTableViewController new]];
    [self addChildWithViewController:[WXMBaseChildTableViewController new]];
    [self addChildWithViewController:[WXMBaseChildTableViewController new]];
}

- (void)addChildWithViewController:(UIViewController *)vc {
    CGFloat contentHeight = self.contentView.frame.size.height;
    vc.tableHeaderHeight = self.tableHeader.frame.size.height;
    vc.rowHeaderHeight = self.rowHeader.frame.size.height;
        
    [self addChildViewController:vc];
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UITableViewController *controller = [self.childViewControllers objectAtIndex:i];
        controller.view.frame = CGRectMake(kSWidth * i, 0, kSWidth, contentHeight);
        [self.contentView addSubview:controller.view];
    }
    
    self.contentView.contentSize = CGSizeMake(kSWidth * self.childViewControllers.count, 0);
}

- (void)childVC:(UIViewController *)childVC scrollView:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat headerH = self.tableHeader.frame.size.height;
    CGFloat rowH = self.rowHeader.frame.size.height;
            
    UIViewController *currentController = self.childViewControllers[self.currentIndex];
    if ([currentController isEqual:childVC]) {
        CGFloat tableTop = MAX(kNBarHeight - offsetY, kNBarHeight - headerH);
        CGFloat tableBottom = CGRectGetMaxY(self.tableHeader.frame);
        self.tableHeader.frame = CGRectMake(0, tableTop, kSWidth, headerH);
        self.loading.frame = CGRectMake(0, tableTop - 50, kSWidth, 50);
        self.rowHeader.frame = CGRectMake(0, tableBottom, kSWidth, rowH);
                
        for (UIViewController *controller in self.childViewControllers) {
            if (![controller isEqual:currentController]) {
                [controller setSlidScrollContentOffsetY:offsetY];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / scrollView.frame.size.width;
    [self selectedIndex:index];
}

- (void)selectedIndex:(NSInteger)index {
    [self.contentView setContentOffset:CGPointMake(index * kSWidth, 0) animated:YES];
    self.currentIndex = index;
    
    UIViewController *controller = [self.childViewControllers objectAtIndex:index];
    UIScrollView *scrollerView = [controller slidScrollView];
    CGFloat contentH = scrollerView.contentSize.height;
    CGFloat scrollerH = scrollerView.frame.size.height;
    self.tableHeader.scrollView = scrollerView;
      
    if (contentH <= scrollerH && scrollerView.contentOffset.y > 0) {
        self.contentView.userInteractionEnabled = NO;
        [scrollerView setContentOffset:CGPointZero animated:YES];
        dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC));
        dispatch_after(when, dispatch_get_main_queue(), ^{
            self.contentView.userInteractionEnabled = YES;
        });
    }
}

- (WXMBaseTabScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[WXMBaseTabScrollView alloc] initWithFrame:kEdgeRect];
        _contentView.delegate = self;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        _contentView.clipsToBounds = YES;
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (WXMBaseTabHeaderView *)tableHeader {
    if (!_tableHeader) {
        CGRect rects = CGRectMake(0, kNBarHeight, kSWidth, 200);
        _tableHeader = [[WXMBaseTabHeaderView alloc] initWithFrame:rects];
        _tableHeader.backgroundColor = [UIColor redColor];
    }
    return _tableHeader;
}

- (UIView *)rowHeader {
    if (!_rowHeader) {
        CGFloat top = CGRectGetMaxY(self.tableHeader.frame);
        _rowHeader = [[UIView alloc] initWithFrame:CGRectMake(0, top, kSWidth, 44)];
        _rowHeader.backgroundColor = [UIColor yellowColor];
    }
    return _rowHeader;
}

- (UIActivityIndicatorView *)loading {
    if (!_loading)  {
        UIActivityIndicatorViewStyle type = UIActivityIndicatorViewStyleGray;
        _loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:type];
        _loading.frame = CGRectMake(0, -50, kSWidth, 50);
        _loading.hidesWhenStopped = NO;
        [_loading startAnimating];
    }
    return _loading;
}
@end

