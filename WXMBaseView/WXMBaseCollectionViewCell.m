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
    if (self = [super initWithFrame:frame]) [self wxm_setupInterface];
    return self;
}

- (void)wxm_setupInterface {
}

@end
