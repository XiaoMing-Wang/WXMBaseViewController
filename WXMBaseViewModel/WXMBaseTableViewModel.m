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
@property(nonatomic, weak, readwrite) UITableView *tableView;
@property(nonatomic, weak, readwrite) UIViewController <WXMTableViewModelProtocol>*viewController;
@end
@implementation WXMBaseTableViewModel
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

+ (instancetype)wxm_tableVieWithViewController:(UIViewController<WXMTableViewModelProtocol>*)viewController {
    WXMBaseTableViewModel *tableViewModel = [self new];
    tableViewModel.viewController = viewController;
    return tableViewModel;
}

- (void)wxm_setTableView:(UITableView *)tableView cellClass:(__nullable Class)cellClass {
    [self wxm_setTableView:tableView dataSource:@[].mutableCopy cellClass:cellClass];
}

- (void)wxm_setTableView:(UITableView *)tableView
              dataSource:(__kindof NSArray * )dataSource
               cellClass:(__nullable Class)cellClass {
   
    self.ident = (self.viewController) ? NSStringFromClass(self.viewController.class) : @"cell";
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.ident forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL sel = @selector(wxm_tableViewHeightForRowAtIndexPath:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wxm_tableViewHeightForRowAtIndexPath:indexPath];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SEL sel = @selector(wxm_tableViewForHeaderHeightInSection:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wxm_tableViewForHeaderHeightInSection:section];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SEL sel = @selector(wxm_tableViewForFooterHeightInSection:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wxm_tableViewForFooterHeightInSection:section];
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SEL sel = @selector(wxm_tableViewForHeaderInSection:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wxm_tableViewForHeaderInSection:section];
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SEL sel = @selector(wxm_tableViewForFooterInSection:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        return [self.viewController wxm_tableViewForFooterInSection:section];
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SEL sel = @selector(wxm_tableViewDidSelectRowAtIndexPath:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wxm_tableViewDidSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -------------------------------- scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    SEL sel = @selector(wxm_scrollViewDidScroll);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wxm_scrollViewDidScroll];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    SEL sel = @selector(wxm_scrollViewWillBeginDragging);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wxm_scrollViewWillBeginDragging];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    SEL sel = @selector(wxm_scrollViewDidEndDraggingWithDecelerate:);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wxm_scrollViewDidEndDraggingWithDecelerate:decelerate];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    SEL sel = @selector(wxm_scrollViewWillBeginDecelerating);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wxm_scrollViewWillBeginDecelerating];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    SEL sel = @selector(wxm_scrollViewDidEndDecelerating);
    if (self.viewController && [self.viewController respondsToSelector:sel]) {
        [self.viewController wxm_scrollViewDidEndDecelerating];
    }
}
#pragma clang diagnostic pop
@end
