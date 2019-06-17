//
//  WXMConmonBaseTableViewCell.h
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXMConmonBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *mainBackground;  /** 背景 */
@property (nonatomic, strong) UILabel *mainTitle;      /** 标题 */
@property (nonatomic, strong) UILabel *mainDetail;     /** 描述 */
@property (nonatomic, strong) UILabel *subDetail;      /** 子描述 */
@property (nonatomic, strong) UIImageView *titleIcon;  /** 左图标 */
@property (nonatomic, strong) UIImageView *detailIcon; /** 描述图标 */
@property (nonatomic, strong) CALayer *lineLabel;      /** 线条 */

/** 初始化 */
- (void)wxm_setupInterface;

/** 布局 */
- (void)wxm_layoutInterface;

@end
