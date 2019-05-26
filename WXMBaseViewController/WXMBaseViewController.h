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
#import <UIKit/UIKit.h>
#import "WXMBaseTableViewModel.h"

@interface WXMBaseViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,WXMTableViewModelProtocol>

@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) UITableView *mainTableView;
@property(nonatomic, strong) UIScrollView *mainScrollView;

/** 转场动画中 */
@property (nonatomic, assign) BOOL transitions;

/** 加载完成 */
@property (nonatomic, assign) BOOL loaded;

/** 状态栏 */
- (UIStatusBarStyle)statusBarStyle;

/** 手势默认YES */
- (BOOL)interactivePop;

@end

