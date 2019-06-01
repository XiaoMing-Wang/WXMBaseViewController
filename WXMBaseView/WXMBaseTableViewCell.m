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
    [self wxm_setupInterface];
    return self;
}

/** 初始化 */
- (void)wxm_setupInterface {
    
}

/** 布局 */
- (void)wxm_layoutInterface {
    
}

@end

