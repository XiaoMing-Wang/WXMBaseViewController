//
//  WXMBaseCollectionViewCell.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseCollectionViewCell.h"

@implementation WXMBaseCollectionViewCell

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeDefaultInterface];
        [self setupAutomaticLayout];
    }
    return self;
}

/** 初始化 */
- (void)initializeDefaultInterface {
    
}

/** 布局 */
- (void)setupAutomaticLayout {
    
}

@end
