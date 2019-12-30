//
//  WXMBaseTableViewModel.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseTableViewModel.h"
@interface WXMBaseTableViewModel ()
@property (nonatomic, copy) NSString *ident;
@property (nonatomic, weak, readwrite) UITableView *tableView;
@property (nonatomic, weak, readwrite) UIViewController<WXMTableViewModelProtocol> *viewController;
@end
@implementation WXMBaseTableViewModel
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

+ (instancetype)tableVieWithController:(UIViewController<WXMTableViewModelProtocol>*)controller {
    WXMBaseTableViewModel *tableViewModel = [self new];
    tableViewModel.viewController = controller;
    return tableViewModel;
}

- (void)setTableView:(UITableView *)tableView cellClass:(__nullable Class)cellClass {
    [self setTableView:tableView dataSource:@[].mutableCopy cellClass:cellClass];
}

- (void)setTableView:(UITableView *)tableView
          dataSource:(__kindof NSArray * )dataSource
           cellClass:(__nullable Class)cellClass {
    
    self.ident = @"cell";
    self.dataSource = dataSource;
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:cellClass forCellReuseIdentifier:self.ident];
}


#pragma mark -------------------------------- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:index];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL sel = @selector(wt_tableViewHeightForRowAtIndexPath:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wt_tableViewHeightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SEL sel = @selector(wt_tableViewForHeaderHeightInSection:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wt_tableViewForHeaderHeightInSection:section];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SEL sel = @selector(wt_tableViewForFooterHeightInSection:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wt_tableViewForFooterHeightInSection:section];
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)table viewForHeaderInSection:(NSInteger)section {
    SEL sel = @selector(wt_tableViewForHeaderInSection:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wt_tableViewForHeaderInSection:section];
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)table viewForFooterInSection:(NSInteger)section {
    SEL sel = @selector(wt_tableViewForFooterInSection:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wt_tableViewForFooterInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SEL sel = @selector(wt_tableViewDidSelectRowAtIndexPath:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wt_tableViewDidSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -------------------------------- scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    SEL sel = @selector(wt_scrollViewDidScroll);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wt_scrollViewDidScroll];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    SEL sel = @selector(wt_scrollViewWillBeginDragging);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wt_scrollViewWillBeginDragging];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    SEL sel = @selector(wt_scrollViewDidEndDraggingWithDecelerate:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wt_scrollViewDidEndDraggingWithDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    SEL sel = @selector(wt_scrollViewWillBeginDecelerating);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wt_scrollViewWillBeginDecelerating];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    SEL sel = @selector(wt_scrollViewDidEndDecelerating);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wt_scrollViewDidEndDecelerating];
    }
}
#pragma clang diagnostic pop
@end
