//
//  WXMBaseViewController.h
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//
#define kFTableAssist(TablesClass) class NSString; \
- (TablesClass *)tableAssist { return (TablesClass *) self.tableViewAssistObject; } \
- (Class)tableViewViewModelClass { return [TablesClass class]; }

#define kFNetworkAssist(NetworkClass) class NSString; \
- (Class)networkViewModelClass { return [NetworkClass class]; } \
- (NetworkClass *)networkAssist { return (NetworkClass *)self.networkAssistObject; } \


#import <UIKit/UIKit.h>
#import "WXMBaseErrorViewProtocol.h"
#import "WXMGlobalStaticFile.h"
#import "WXMBaseTableHandler.h"
#import "WXMBaseNetworkAssist.h"

@interface WXMBaseViewController : UIViewController
<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, WXMTableViewModelProtocol>

@property (nonatomic, assign) BOOL hiddenNavigationLine;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong, readonly) WXMBaseNetworkAssist *networkAssistObject;
@property (nonatomic, strong, readonly) WXMBaseTableHandler *tableViewAssistObject;

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

/** viewmodel类 */
- (Class)tableViewViewModelClass;

/** network类 */
- (Class)networkViewModelClass;

/** 子类覆盖该方法强制转换 */
- (__kindof WXMBaseNetworkAssist *)networkAssist;
- (__kindof WXMBaseTableHandler *)tableAssist;

@end

