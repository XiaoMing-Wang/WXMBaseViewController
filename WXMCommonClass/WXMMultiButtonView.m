//
//  WXMMultiFunctionView.m
//  ModuleDebugging
//
//  Created by edz on 2019/6/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import "WXMMultiButtonView.h"
@interface WXMMultiButtonView ()

@end

@implementation WXMMultiButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultInterface];
        [self setupAutomaticLayout];
    }
    return self;
}

/** 初始化界面 */
- (void)setupDefaultInterface {
    if (_multiButtonType == WXMMultiButtonTypeImageMassage) {
        [self addSubview:self.lordimageView];
        [self addSubview:self.titlesLabel];
    }
}

/** 布局 */
- (void)setupAutomaticLayout {
    if (_multiButtonType == WXMMultiButtonTypeImageMassage) {
        CGSize imageSize = self.lordimageView.image.size;
        if (!CGSizeEqualToSize(_lordiImageSize, CGSizeZero)) imageSize = _lordiImageSize;
        self.lordimageView.frame = (CGRect){CGPointZero,imageSize};
        [self.titlesLabel sizeToFit];
        [self wxm_venicalSet:_lordimageView nether:_titlesLabel interval:self.interval];
    }
}

- (void)setMultiButtonType:(WXMMultiButtonType)multiButtonType {
    _multiButtonType = multiButtonType;
    [self setupAutomaticLayout];
}

- (void)setLordiImageSize:(CGSize)lordiImageSize {
    _lordiImageSize = lordiImageSize;
    _lordimageView.frame = (CGRect){_lordimageView.frame.origin,lordiImageSize};
    [self setupAutomaticLayout];
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    _titlesLabel.text = titleString;
    [_titlesLabel sizeToFit];
    [self setupAutomaticLayout];
}

- (void)didMoveToSuperview {
    if (self.superview) [self setupAutomaticLayout];
}

/** 上下居中对齐 */
- (void)wxm_venicalSet:(UIView *)above nether:(UIView *)nether interval:(CGFloat)interval {
    if (!above || !nether || self.frame.size.height == 0) return;
    CGFloat totalHeight = self.frame.size.height;
    CGFloat totalInterval = totalHeight - above.frame.size.height - nether.frame.size.height;
    CGFloat topAbove = (totalInterval - interval) / 2.0;
    CGRect rectAbove = above.frame;
    rectAbove.origin.y = topAbove + self.lordiImageOffset;
    above.frame = rectAbove;
    
    CGRect rectNether = nether.frame;
    rectNether.origin.y = totalHeight - topAbove - nether.frame.size.height;
    nether.frame = rectNether;
}

/** 左右居中对齐 */
- (void)wxm_horizontalSet:(UIView *)left nether:(UIView *)right interval:(CGFloat)interval {
    if (!left || !right || self.frame.size.width == 0) return;
    CGFloat totalWidth = self.frame.size.width;
    CGFloat totalInterval = totalWidth - left.frame.size.width - right.frame.size.width;
    CGFloat topAbove = (totalInterval - interval) / 2.0;
    CGRect rectAbove = left.frame;
    rectAbove.origin.x = topAbove + self.lordiImageOffset;
    left.frame = rectAbove;
    
    CGRect rectNether = right.frame;
    rectNether.origin.x = totalWidth - topAbove - right.frame.size.width;
    right.frame = rectNether;
}

- (UILabel *)titlesLabel {
    if (!_titlesLabel) {
        _titlesLabel = [[UILabel alloc] init];
        _titlesLabel.textAlignment = NSTextAlignmentCenter;
        _titlesLabel.font = [UIFont systemFontOfSize:16];
        _titlesLabel.textColor = [UIColor blackColor];
        _titlesLabel.numberOfLines = 1;
    }
    return _titlesLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) _detailLabel = [[UILabel alloc] init];
    return _detailLabel;
}

- (UIImageView *)lordimageView {
    if (!_lordimageView) {
        _lordimageView = [[UIImageView alloc] init];
        _lordimageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _lordimageView;
}

- (UIImageView *)detaimagelView {
    if (!_detaimagelView) {
        _detaimagelView = [[UIImageView alloc] init];
        _detaimagelView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _detaimagelView;
}
@end
