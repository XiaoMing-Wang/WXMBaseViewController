//
//  WXMBaseTabScrollView.h
//  Multi-project-coordination
//
//  Created by wq on 2020/1/20.
//  Copyright © 2020 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXMBaseTabHeaderView : UIView
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIView *> *hitTestViews;
@end

@interface WXMBaseTabScrollView : UIScrollView
@property (nonatomic, assign) CGPoint currentPoint;
@end

NS_ASSUME_NONNULL_END
