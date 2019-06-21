//
//  WXMConmonBaseTableViewCell.m
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMConmonBaseTableViewCell.h"

@implementation WXMConmonBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self wxm_setupInterface];
    [self wxm_layoutInterface];
    return self;
}

/** 初始化 */
- (void)wxm_setupInterface {
    
}

/** 布局 */
- (void)wxm_layoutInterface {
    
}

@end
