//
//  WXMBaseViewController.h
//  ModuleDebugging
//
//  Created by edz on 2019/5/6.
//  Copyright © 2019年 wq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMBaseErrorViewProtocol.h"
#import "WXMGlobalStaticFile.h"
#import "WXMBaseTableViewModel.h"
#import "WXMBaseNetworkViewModel.h"

@interface WXMBaseViewController : UIViewController
<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,WXMTableViewModelProtocol>

@property (nonatomic, assign) BOOL hiddenNavigationLine;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *dataSource;
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
- (UITableView *)tableViewGrouped;

/** 初始化 */
- (void)initializeDefaultInterface;

/** viewmodel类 */
- (Class)tableViewViewModelClass;

/** network类 */
- (Class)networkViewModelClass;

/** 子类覆盖该方法强制转换 */
- (__kindof WXMBaseNetworkViewModel *)currentNetwork;

//- (__kindof WXMBaseNetworkViewModel *)currentNetwork {
//    return (WXMBaseNetworkViewModel *)self.networkViewModel;
//}

@end

