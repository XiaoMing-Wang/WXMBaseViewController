//
//  WXMBaseTabScrollView.m
//  Multi-project-coordination
//
//  Created by wq on 2020/1/20.
//  Copyright © 2020 wxm. All rights reserved.
//

#import "WXMBaseTabScrollView.h"

@implementation WXMBaseTabHeaderView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitTestView = [super hitTest:point withEvent:event];
    if ([self.hitTestViews containsObject:hitTestView]) {
        return hitTestView;
    }
    if (hitTestView) return self.scrollView;
    return nil;
}

@end

@implementation WXMBaseTabScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self setupTouches];
    return self;
}

- (void)setupTouches {
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)view;
        if (tableView.tableHeaderView) {
            return !CGRectContainsPoint(tableView.tableHeaderView.frame, self.currentPoint);
        }
        return YES;
        
    } else if ([view isMemberOfClass:[UITableViewHeaderFooterView class]] ||
               [view isKindOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")]) {
        
        return NO;
    }
    
    return YES;
}

- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches  withEvent:(nullable UIEvent *)event inContentView:(UIView *)view {
    CGPoint point = [[touches anyObject] locationInView:view];
    self.currentPoint = point;
    return YES;
}

@end


