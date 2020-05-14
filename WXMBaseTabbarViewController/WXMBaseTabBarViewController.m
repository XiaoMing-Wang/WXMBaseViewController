//
//  WXMBaseTabBarViewController.m
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//

#import "WXMBaseTabBarViewController.h"

NSString *const WXMTabBarDoubleClick = @"WXMTabBarDoubleClick";
@interface WXMBaseTabBarViewController () <UITabBarControllerDelegate>
@property (nonatomic, strong) NSDate *lastDate;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation WXMBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    [self setupBaseTabBarViewController];
}

- (void)setupBaseTabBarViewController {
    UITabBarItem *item = [UITabBarItem appearance];
    UIColor *seColor = [UIColor redColor];
    UIColor *deColor = [UIColor blackColor];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:seColor} forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:deColor} forState:UIControlStateNormal];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self.tabBar setShadowImage:[UIImage imageNamed:@""]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.array enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
        [self addChildViewController:dic[@"viewController"]
                                 nav:dic[@"navigationController"]
                               title:dic[@"title"]
                               image:dic[@"icon"]
                       selectedImage:dic[@"seicon"]
                         imageInsets:UIEdgeInsetsMake(0, 0, 0, 0) /** (6, 0, -6, 0)图片位置 大小和图片一样 */
                       titlePosition:UIOffsetMake(0, -1.2)];      /** 字体位置 */
    }];
}

- (NSArray *)array {
    return @[@{@"viewController" : @"HomeViewController",
               @"navigationController" : @"WXMBaseNavigationController",
               @"title" : @"首页",
               @"icon" : @"ic_home",
               @"seicon" : @"ic_home_s"},
             
             @{@"viewController" : @"TestListViewController",
               @"navigationController" : @"WXMBaseNavigationController",
               @"title" : @"商城",
               @"icon" : @"ic_mall",
               @"seicon" : @"ic_mall_s"},
             
             @{ @"viewController" : @"HomeViewController",
                @"navigationController" : @"WXMBaseNavigationController",
                @"title" : @"我的",
                @"icon" : @"ic_my",
                @"seicon" : @"ic_my_s"}
             ];
}

- (void)addChildViewController:(NSString *)viewController
                           nav:(NSString *)nav
                         title:(NSString *)title
                         image:(NSString *)image
                 selectedImage:(NSString *)selecteds
                   imageInsets:(UIEdgeInsets)imageInsets
                 titlePosition:(UIOffset)titlePosition  {
    UIImageRenderingMode model = UIImageRenderingModeAlwaysOriginal;
    UIViewController *vc = [NSClassFromString(viewController) new];
    UINavigationController *navigationController = [[NSClassFromString(nav) alloc] initWithRootViewController:vc];
    
    navigationController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:model];
    navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:selecteds] imageWithRenderingMode:model];
    
    navigationController.tabBarItem.imageInsets = imageInsets;
    navigationController.tabBarItem.titlePositionAdjustment = titlePosition;
    navigationController.title = title;
    [self addChildViewController:navigationController];
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
    
    NSDate *date = [[NSDate alloc] init];
    if (tabBarController.selectedIndex == _currentIndex &&
        (date.timeIntervalSince1970 - _lastDate.timeIntervalSince1970 < 0.4)) {
        UINavigationController *navigation = tabBarController.selectedViewController;
        NSString *classString = NSStringFromClass(navigation.visibleViewController.class);
        NSNotificationCenter *kCenter = [NSNotificationCenter defaultCenter];
        [kCenter postNotificationName:WXMTabBarDoubleClick object:classString];
    }
    if (tabBarController.selectedIndex == _currentIndex) _lastDate = date;
    _currentIndex = tabBarController.selectedIndex;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.hidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

@end
