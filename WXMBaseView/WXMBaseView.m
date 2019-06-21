//
//  WXMBaseView.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseView.h"

@implementation WXMBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultInterface];
        [self setupAutomaticLayout];
    }
    return self;
}

/** 初始化界面 */
- (void)setupDefaultInterface {
    
}

/** 布局 */
- (void)setupAutomaticLayout {
    
}

- (void)didMoveToSuperview {
    if (self.superview) [self setupAutomaticLayout];
}

@end
