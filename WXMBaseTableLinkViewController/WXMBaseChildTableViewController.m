//
//  WXMBaseChildTableViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2020/1/20.
//  Copyright © 2020 wxm. All rights reserved.
//
#import "WXMCategoryHeader.h"
#import "WXMMJDIYHeader.h"
#import "WXMBaseTableLinkViewController.h"
#import "WXMBaseChildTableViewController.h"
#import "UIViewController+WXMTableSliding.h"

@implementation WXMBaseChildTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setSlidScrollView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    WXMMJDIYHeader * mjDIYHeader =  [WXMMJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHeaderControl)];
    mjDIYHeader.alpha = 0;
    self.tableView.mj_header = mjDIYHeader;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)requestHeaderControl {
    SEL sel = NSSelectorFromString(@"requestDataSources");
    for (UIViewController *vc in self.parentViewController.childViewControllers) {
        if ([vc respondsToSelector:sel]) [vc performSelector:sel];
    }
}
#pragma clang diagnostic pop

- (void)requestDataSources {
    NSLog(@"xxxxxxxxxxxxxxxxx  %@", self);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return random() % 2 == 0 ? 20 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)index {
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"cell" forIndexPath:index];
    cell.contentView.backgroundColor = KRandomColor;
    return cell;
}




@end
