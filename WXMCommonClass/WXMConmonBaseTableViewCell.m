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
    return self;
}

/** 初始化 */
- (void)wxm_setupInterface {
    
}

/** 布局 */
- (void)wxm_layoutInterface {
    
}

- (UIView *)mainBackground {
    if (!_mainBackground) _mainBackground = [[UIView alloc] init];
    return _mainBackground;
}

- (UILabel *)mainTitle {
    if (!_mainTitle) _mainTitle = [[UILabel alloc] init];
    return _mainTitle;
}

- (UILabel *)mainDetail {
    if (!_mainDetail) _mainDetail = [[UILabel alloc] init];
    return _mainDetail;
}

- (UILabel *)subDetail {
    if (!_subDetail) _subDetail = [[UILabel alloc] init];
    return _subDetail;
}

- (UIImageView *)titleIcon {
    if (!_titleIcon) _titleIcon = [[UIImageView alloc] init];
    return _titleIcon;
}

- (UIImageView *)detailIcon {
    if (!_detailIcon) _detailIcon = [[UIImageView alloc] init];
    return _detailIcon;
}

- (CALayer *)lineLabel {
    if (!_lineLabel) _lineLabel = [[CALayer alloc] init];
    return _lineLabel;
}

@end
