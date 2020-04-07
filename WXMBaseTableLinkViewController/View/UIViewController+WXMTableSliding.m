//
//  UIViewController+WXMTableSliding.m
//  Multi-project-coordination
//
//  Created by wq on 2020/1/20.
//  Copyright © 2020 wxm. All rights reserved.
//
#import <objc/runtime.h>
#import "UIViewController+WXMTableSliding.h"

@implementation UIViewController (WXMTableSliding)

- (void)setSlidScrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat allHeight = self.tableHeaderHeight + self.rowHeaderHeight;
    
    if ([self isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableVC = (UITableViewController *)self;
        UITableViewHeaderFooterView *headerV = [UITableViewHeaderFooterView new];
        headerV.frame = CGRectMake(0, 0, width, allHeight);
        tableVC.tableView.tableHeaderView = headerV;
        tableVC.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(allHeight, 0, 0, 0);
        tableVC.tableView.delaysContentTouches = NO;
        tableVC.tableView.canCancelContentTouches = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.parentViewController respondsToSelector:@selector(childVC:scrollView:)]) {
        [self.parentViewController performSelector:@selector(childVC:scrollView:)
                                        withObject:self
                                        withObject:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.parentViewController respondsToSelector:@selector(childVC:scrollView:)]) {
        [self.parentViewController performSelector:@selector(childVC:scrollView:)
                                        withObject:self
                                        withObject:scrollView];
    }
}

- (UIScrollView *)slidScrollView {
    if ([self isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableVC = (UITableViewController *)self;
        return tableVC.tableView;
    }
    return nil;
}

- (void)setSlidScrollContentOffsetY:(CGFloat)offsetY {
    if (![self isKindOfClass:[UITableViewController class]]) return;
    
    UITableViewController *tableVC = (UITableViewController *)self;
    UITableView *tableView = tableVC.tableView;
    CGFloat tableOffsetY = tableView.contentOffset.y;
    
    if (offsetY <= self.tableHeaderHeight) {
        [tableView setContentOffset:CGPointMake(0, offsetY)];
    } else if (tableOffsetY < offsetY && tableOffsetY < self.tableHeaderHeight) {
        [tableView setContentOffset:CGPointMake(0, self.tableHeaderHeight)];
    }
}

- (void)setTableHeaderHeight:(CGFloat)tableHeaderHeight {
    objc_setAssociatedObject(self, @selector(tableHeaderHeight), @(tableHeaderHeight), 3);
}

- (CGFloat)tableHeaderHeight {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setRowHeaderHeight:(CGFloat)rowHeaderHeight {
    objc_setAssociatedObject(self, @selector(rowHeaderHeight), @(rowHeaderHeight), 3);
}

- (CGFloat)rowHeaderHeight {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

@end
