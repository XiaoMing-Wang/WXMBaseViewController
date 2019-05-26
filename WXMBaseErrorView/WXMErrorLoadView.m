//
//  WXMErrorLoadView.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//
#define WXM_SWidth [UIScreen mainScreen].bounds.size.width
#define WXM_SHeight [UIScreen mainScreen].bounds.size.height
#import "WXMErrorLoadView.h"
#import "UIView+WXMErrorStatusView.h"

@interface WXMErrorLoadView ()
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@end
@implementation WXMErrorLoadView

+ (WXMErrorLoadView *)wxm_errorsLoadView {
    WXMErrorLoadView *loadView = [WXMErrorLoadView new];
    loadView.tag = WXM_ErrorSign;
    [loadView setupInterface];
    return loadView;
}

- (void)setupInterface {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = WXM_BackgroundColor;
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:2];
    [_indicator startAnimating];
    [self addSubview:_indicator];
}

/** 更新frame */
- (void)wxm_modifyCoordinate {
    if (!self.superview) return;
    self.frame = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    _indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

- (void)didMoveToSuperview {
    if (self.superview) [self wxm_modifyCoordinate];
}
@end
