//
//  UIViewController+WXMTableSliding.h
//  Multi-project-coordination
//
//  Created by wq on 2020/1/20.
//  Copyright © 2020 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WXMTableSlidDelegate <NSObject>
- (void)childVC:(UIViewController *)childVC scrollView:(UIScrollView *)scrollView;
@end

@interface UIViewController (WXMTableSliding)

/** header高度 */
@property (nonatomic, assign) CGFloat tableHeaderHeight;

/** row高度 */
@property (nonatomic, assign) CGFloat rowHeaderHeight;

- (UIScrollView *)slidScrollView;
- (void)setSlidScrollView;
- (void)setSlidScrollContentOffsetY:(CGFloat)offsetY;
@end

NS_ASSUME_NONNULL_END
