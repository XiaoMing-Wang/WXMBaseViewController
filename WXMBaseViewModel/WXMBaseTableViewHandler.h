//
//  WXMBaseTableViewModel.h
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WXMBaseReplaceMacro.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol WXMTableViewHandleProtocol<NSObject>
@optional
- (UIView *)wt_tableViewForHeaderInSection:(NSInteger)section;
- (UIView *)wt_tableViewForFooterInSection:(NSInteger)section;
- (CGFloat)wt_tableViewForHeaderHeightInSection:(NSInteger)section;
- (CGFloat)wt_tableViewForFooterHeightInSection:(NSInteger)section;
- (CGFloat)wt_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)wt_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)index;
- (void)wt_scrollViewDidScroll;
- (void)wt_scrollViewWillBeginDragging;
- (void)wt_scrollViewDidEndDraggingWithDecelerate:(BOOL)decelerate;
- (void)wt_scrollViewWillBeginDecelerating;
- (void)wt_scrollViewDidEndDecelerating;
- (void)wt_tableCustomEvent:(NSString *)event object:(id)object;
@end

@interface WXMBaseTableViewHandler : NSObject
<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, WXMHandlerProtocol>

@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, weak, readonly) id <WXMTableViewHandleProtocol>delegate;

/** 初始化 */
- (instancetype)initWithDelegate:(id<WXMTableViewHandleProtocol>)delegate;

/** 设置默认数据 */
- (void)initializationVariable;
- (void)setDataSourceAndReload:(NSMutableArray *)dataSource;
- (void)addDataSourceAndReload:(NSMutableArray *)dataSource;
- (void)setTableView:(UITableView *)tableView cellClass:(__nullable Class)cellClass;
- (void)setTableView:(UITableView *)tableView
          dataSource:(__kindof NSArray *)dataSource
           cellClass:(__nullable Class)cellClass;

@end

NS_ASSUME_NONNULL_END
