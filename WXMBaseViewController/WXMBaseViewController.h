//
//  WXMBaseViewController.h
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WXMGlobalStaticFile.h"
#import "WXMBaseReplaceMacro.h"
#import "WXMBaseNetworkhandler.h"
#import "WXMBaseTableViewhandler.h"
#import "WXMBaseErrorViewProtocol.h"

@interface WXMBaseViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, WXMTableViewHandleProtocol, WXMBaseNetworkHandlerProtocol>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
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

/** 子类自定义 */
- (void)initializeDefaultInterface;

@end

