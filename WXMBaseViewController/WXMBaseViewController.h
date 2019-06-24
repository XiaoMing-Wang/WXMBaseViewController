//
//  WXMBaseViewController.h
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//
#define WXMBase_Width [UIScreen mainScreen].bounds.size.width
#define WXMBase_Height [UIScreen mainScreen].bounds.size.height
#define WXMBase_Iphonex ((WXMBase_Height == 812.0f) ? YES : NO)
#define WXMBase_BarHeight ((WXMBase_Iphonex) ? 88.0f : 64.0f)
#define WXMBase_Rect \
CGRectMake(0, WXMBase_BarHeight, WXMBase_Width, WXMBase_Height - WXMBase_BarHeight)

#import <UIKit/UIKit.h>
#import "WXMBaseErrorViewProtocol.h"
#import "WXMBaseTableViewModel.h"
#import "WXMBaseNetworkViewModel.h"

@interface WXMBaseViewController : UIViewController
<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, WXMTableViewModelProtocol>

@property (nonatomic, assign) BOOL hiddenNavigationLine;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) WXMBaseNetworkViewModel *networkViewModel;
@property (nonatomic, strong) WXMBaseTableViewModel *tableViewViewModel;

/** 转场动画中 */
@property (nonatomic, assign) BOOL transitions;

/** 加载完成 */
@property (nonatomic, assign) BOOL loaded;

/** 状态栏 */
- (UIStatusBarStyle)statusBarStyle;

/** 手势默认YES */
- (BOOL)interactivePop;

/** 切换成分组模式 */
- (UITableView *)mainTableViewGrouped;
@end

