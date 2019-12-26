//
//  WXMBaseTableViewCell.m
//  Multi-project-coordination
//
//  Created by wq on 2019/5/26.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseTableViewCell.h"

@implementation WXMBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initializeDefaultInterface];
    [self setupAutomaticLayout];
    return self;
}

/** 初始化 */
- (void)initializeDefaultInterface {
    
}

/** 布局 */
- (void)setupAutomaticLayout {
    
}

@end

