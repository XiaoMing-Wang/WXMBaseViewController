//
//  WXMBaseViewController.h
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//

#define kFNetworkHandle(networkClass) class NSObject; \
- (Class)networkViewModelClass { return networkClass.class; } \
- (networkClass *)networkHandle {  return (networkClass *) [self valueForKey:@"networkObject"]; }

#define kFTableHandle(tableClass) class NSObject; \
- (Class)tableViewModelClass { return tableClass.class; } \
- (tableClass *)tableHandle {  return (tableClass *) [self valueForKey:@"tableViewObject"]; }

#import <UIKit/UIKit.h>
#import "WXMBaseErrorViewProtocol.h"
#import "WXMGlobalStaticFile.h"
#import "WXMBaseTableHandler.h"
#import "WXMBaseListNetworkHandler.h"
#import "WXMBaseTableHandler.h"

@interface WXMBaseViewController : UIViewController
<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, WXMTableViewModelProtocol>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL hiddenNavigationLine;
@property (nonatomic, strong) NSMutableArray *dataSource;

/** 转场动画中 */
@property (nonatomic, assign) BOOL transitions;

/** 加载完成 */
@property (nonatomic, assign) BOOL loaded;

/** 状态栏 */
- (UIStatusBarStyle)statusBarStyle;

/** 手势默认YES */
- (BOOL)interactivePop;

/** 切换成分组模式 */
- (UITableView *)tableViewGrouped;

/** 初始化 */
- (void)initializeDefaultInterface;

- (Class)tableViewModelClass;
- (Class)networkViewModelClass;
- (__kindof WXMBaseTableHandler *)tableHandle;
- (__kindof WXMBaseListNetworkHandler *)networkHandle;

@end

