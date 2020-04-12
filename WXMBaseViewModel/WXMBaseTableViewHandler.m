//
//  WXMBaseTableViewModel.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#import <objc/runtime.h>
#import "WXMBaseTableViewHandler.h"

static char tablehandler;
@interface WXMBaseTableViewHandler ()
@property (nonatomic, copy) NSString *ident;
@property (nonatomic, weak, readwrite) UITableView *tableView;
@property (nonatomic, weak, readwrite) id <WXMTableViewHandleProtocol>delegate;
@property (nonatomic, weak, readwrite) UIViewController <WXMTableViewHandleProtocol> *controller;
@end
@implementation WXMBaseTableViewHandler
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

/** 这个方法是占位做提示用的 会被宏替换成singletonhandler */
+ (instancetype)handler {
    return nil;
}

/** 把handler绑定在控制器上 生命周期由控制器管理 */
+ (instancetype (^)(id<WXMTableViewHandleProtocol> delegate))singletonhandler {
    return ^(id<WXMTableViewHandleProtocol> delegate) {
        WXMBaseTableViewHandler *handlers = objc_getAssociatedObject(delegate, &tablehandler);
        if (handlers == nil) {
            handlers = [[self alloc] initWithDelegate:delegate];
            objc_setAssociatedObject(delegate, &tablehandler, handlers, 1);
        }
        return handlers;
    };
}

- (instancetype)initWithDelegate:(id<WXMTableViewHandleProtocol>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        if ([delegate isKindOfClass:UIViewController.class]) {
            self.controller = (UIViewController <WXMTableViewHandleProtocol> *)delegate;
        }
        [self initializationVariable];
    }
    return self;
}

- (void)initializationVariable {}

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
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        return [self.delegate wt_tableViewHeightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SEL sel = @selector(wt_tableViewForHeaderHeightInSection:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        return [self.delegate wt_tableViewForHeaderHeightInSection:section];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SEL sel = @selector(wt_tableViewForFooterHeightInSection:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        return [self.delegate wt_tableViewForFooterHeightInSection:section];
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)table viewForHeaderInSection:(NSInteger)section {
    SEL sel = @selector(wt_tableViewForHeaderInSection:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        return [self.delegate wt_tableViewForHeaderInSection:section];
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)table viewForFooterInSection:(NSInteger)section {
    SEL sel = @selector(wt_tableViewForFooterInSection:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        return [self.delegate wt_tableViewForFooterInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SEL sel = @selector(wt_tableViewDidSelectRowAtIndexPath:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        [self.delegate wt_tableViewDidSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -------------------------------- scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    SEL sel = @selector(wt_scrollViewDidScroll);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        [self.delegate wt_scrollViewDidScroll];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    SEL sel = @selector(wt_scrollViewWillBeginDragging);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        [self.delegate wt_scrollViewWillBeginDragging];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    SEL sel = @selector(wt_scrollViewDidEndDraggingWithDecelerate:);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        [self.delegate wt_scrollViewDidEndDraggingWithDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    SEL sel = @selector(wt_scrollViewWillBeginDecelerating);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        [self.delegate wt_scrollViewWillBeginDecelerating];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    SEL sel = @selector(wt_scrollViewDidEndDecelerating);
    if (self.delegate && [self.delegate respondsToSelector:sel]) {
        [self.delegate wt_scrollViewDidEndDecelerating];
    }
}
#pragma clang diagnostic pop

@end
