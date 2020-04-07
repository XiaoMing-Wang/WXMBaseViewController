//
//  WXMBaseSearchViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2020/1/19.
//  Copyright © 2020 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 搜索界面 */
@class WXMSearchResultViewController;
@interface WXMBaseSearchViewController : UIViewController
<UISearchBarDelegate, UISearchResultsUpdating,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) NSString *attributesKey;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) void (^callback)(id resultsObj);

@property (nonatomic, strong) UIView *whiteFill;
@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) WXMSearchResultViewController *resultsVC;

- (void)loadCell:(UITableViewCell *)cell dataSource:(NSArray *)data index:(NSIndexPath *)index;

@end


NS_ASSUME_NONNULL_END
