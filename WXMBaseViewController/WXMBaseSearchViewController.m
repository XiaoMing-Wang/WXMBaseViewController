//
//  WXMBaseSearchViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2020/1/19.
//  Copyright © 2020 wxm. All rights reserved.
//
#define kWindow [[[UIApplication sharedApplication] delegate] window]
#define kSWidth [UIScreen mainScreen].bounds.size.width
#define kSHeight [UIScreen mainScreen].bounds.size.height
#define kH kSHeight - kNBarHeight
#define kSearchH 50

#define kNBarHeight ((kIPhoneX) ? 88.0f : 64.0f)
#define kSafeHeight ((kIPhoneX) ? 25.0f : 0.0f)

#define kIPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);\
})

#import "WXMBaseSearchViewController.h"

/** 搜索结果 */
@interface WXMSearchResultViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) NSString *inputString;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UINavigationController *navigation;

@property (nonatomic, strong) void (^callback) (id);
@property (nonatomic, strong) void (^dataBlock) (UITableViewCell *, NSArray *, NSIndexPath *);

@end

@implementation WXMBaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIImage *images = [self colorToImage:UIColor.whiteColor];
    self.definesPresentationContext = YES;
    self.navigationController.navigationBar.translucent = YES; 
    [self.navigationController.navigationBar setBackgroundImage:images forBarMetrics:0];
    [self.navigationController.navigationBar setShadowImage:images];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNBarHeight, kSWidth, kH)];
    self.tableView.rowHeight = self.rowHeight ?: 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.whiteFill = [[UIView alloc] initWithFrame:CGRectMake(0, -kSHeight, kSWidth, kSHeight)];
    self.whiteFill.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:self.whiteFill];
    
    [self.view addSubview:self.tableView];
    NSArray *items = @[UISearchBar.class];
    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:items].title = @"取消";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tab cellForRowAtIndexPath:(NSIndexPath *)index {
    UITableViewCell *cell = [tab dequeueReusableCellWithIdentifier:@"cell" forIndexPath:index];
    [self loadCell:cell dataSource:self.dataSource index:index];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [kWindow endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.callback) self.callback([self.dataSource objectAtIndex:indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    searchController.searchResultsController.view.hidden = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSMutableArray *mutableArray = @[].mutableCopy;
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *value = @"nil";
        if ([obj isKindOfClass:NSString.class]) {
            value = obj;
        } else if ([obj isKindOfClass:NSObject.class] && self.attributesKey) {
            value = [obj valueForKey:self.attributesKey];
        }  else if ([obj isKindOfClass:NSDictionary.class] && self.attributesKey) {
            value = [obj objectForKey:self.attributesKey];
        }
                    
        if (([value rangeOfString:searchText].location != NSNotFound)){
            [mutableArray addObject:obj];
        }
    }];
    
    self.resultsVC.inputString = searchBar.text;
    self.resultsVC.dataSource = mutableArray;
}

- (void)loadCell:(UITableViewCell *)cell dataSource:(NSArray *)data index:(NSIndexPath *)index {
     cell.textLabel.text = @(index.row).stringValue;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kSafeHeight, 0);
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController =
        [[UISearchController alloc] initWithSearchResultsController:self.resultsVC];
        _searchController.searchBar.frame = CGRectMake(0, 0, kSWidth, kSearchH);
        _searchController.searchBar.backgroundColor = [UIColor whiteColor];
        _searchController.searchBar.barTintColor = [UIColor whiteColor];
        _searchController.searchBar.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        
        UIImage *backgroundImage = [self colorToImage:UIColor.whiteColor];
        [_searchController.searchBar setBackgroundImage:backgroundImage];
        
        UIImageView *images = _searchController.searchBar.subviews.firstObject.subviews.firstObject;
        images.layer.borderColor = [UIColor whiteColor].CGColor;
        images.layer.borderWidth = 1;
    }
    return _searchController;
}

- (WXMSearchResultViewController *)resultsVC {
    if (!_resultsVC) {
        _resultsVC = [WXMSearchResultViewController new];
        _resultsVC.navigation = self.navigationController;
        _resultsVC.previewView = self.previewView;
        _resultsVC.callback = self.callback;
        _resultsVC.rowHeight = self.rowHeight;
                        
        __weak __typeof (self) self_weak = self;
        _resultsVC.dataBlock = ^(UITableViewCell *cell, NSArray *dataSource, NSIndexPath *index) {
            [self_weak loadCell:cell dataSource:dataSource index:index];
        };
    }
    return _resultsVC;
}

- (UIView *)previewView {
    if (!_previewView) {
        _previewView = [[UIControl alloc] initWithFrame:CGRectMake(0,kNBarHeight,kSWidth,kSHeight)];
        _previewView.backgroundColor = [UIColor whiteColor];
    }
    return _previewView;
}

- (UIImage *)colorToImage:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation WXMSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.cellClass) self.cellClass = [UITableViewCell class];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kNBarHeight,kSWidth,kH)];
    self.tableView.rowHeight = self.rowHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:@"cell"];
    
    SEL sel = @selector(hideKeyboard);
    UIButton *hiddenView = [[UIButton alloc] initWithFrame:self.tableView.bounds];
    [hiddenView addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self.previewView insertSubview:hiddenView atIndex:0];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.previewView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tab cellForRowAtIndexPath:(NSIndexPath *)index {
    UITableViewCell *cell = [tab dequeueReusableCellWithIdentifier:@"cell" forIndexPath:index];
    if (self.dataBlock) self.dataBlock(cell, self.dataSource, index);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideKeyboard];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.callback) self.callback([self.dataSource objectAtIndex:indexPath.row]);
    [self.navigation popViewControllerAnimated:YES];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (void)setInputString:(NSString *)inputString {
    _inputString = inputString;
    self.previewView.hidden = (inputString.length > 0);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyboard];
}

- (void)hideKeyboard {
    [kWindow endEditing:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
