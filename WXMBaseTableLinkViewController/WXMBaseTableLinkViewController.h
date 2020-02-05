//
//  WXMBaseTableLinkViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2020/1/20.
//  Copyright © 2020 wxm. All rights reserved.
//
#import "WXMBaseTabScrollView.h"
#import "WXMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class WXMBaseTabHeaderView;
@class WXMBaseChildTableViewController;
@interface WXMBaseTableLinkViewController : UIViewController <UIScrollViewDelegate>

/** headerView */
@property (nonatomic, strong) WXMBaseTabHeaderView *tableHeader;

/** rowView */
@property (nonatomic, strong) UIView *rowHeader;

/** 横向滚动 */
@property (nonatomic, strong) WXMBaseTabScrollView *contentView;

/** 添加子控制器 */
- (void)addChildWithViewController:(__kindof WXMBaseChildTableViewController *)vc;

@end

NS_ASSUME_NONNULL_END
