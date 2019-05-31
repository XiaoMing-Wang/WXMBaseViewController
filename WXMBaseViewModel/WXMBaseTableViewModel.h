//
//  WXMBaseTableViewModel.h
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol WXMTableViewModelProtocol<NSObject>
@optional

- (UIView *)wxm_tableViewForHeaderInSection:(NSInteger)section;
- (UIView *)wxm_tableViewForFooterInSection:(NSInteger)section;
- (CGFloat)wxm_tableViewForHeaderHeightInSection:(NSInteger)section;
- (CGFloat)wxm_tableViewForFooterHeightInSection:(NSInteger)section;
- (CGFloat)wxm_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)wxm_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)index;
- (void)wxm_scrollViewDidScroll;
- (void)wxm_scrollViewWillBeginDragging;
- (void)wxm_scrollViewDidEndDraggingWithDecelerate:(BOOL)decelerate;
- (void)wxm_scrollViewWillBeginDecelerating;
- (void)wxm_scrollViewDidEndDecelerating;
@end

@interface WXMBaseTableViewModel : NSObject <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic, strong, readonly) NSMutableArray *dataSource;
@property(nonatomic, weak, readonly) UITableView *tableView;
@property(nonatomic, weak, readonly) UIViewController <WXMTableViewModelProtocol>*viewController;

+ (instancetype)wxm_tableVieWithViewController:(UIViewController *)controller;
- (void)wxm_setTableView:(UITableView *)tableView cellClass:(__nullable Class)cellClass;
- (void)wxm_setTableView:(UITableView *)tableView
              dataSource:(__kindof NSArray *)dataSource
               cellClass:(__nullable Class)cellClass;

@end
NS_ASSUME_NONNULL_END
