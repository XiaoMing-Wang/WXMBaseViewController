//
//  WXMCommonBaseCustomView.m
//  ModuleDebugging
//
//  Created by edz on 2019/6/17.
//  Copyright © 2019 wq. All rights reserved.
//
#define WXMCommonW [UIScreen mainScreen].bounds.size.width
#import "WXMCommonBaseCustomView.h"

@interface WXMCommonBaseCustomView ()
@property (nonatomic, assign) WXMCommonTextFieldLineType lineType;
@end

@implementation WXMCommonBaseCustomView

#pragma mark _________________________________ 自定义类型UI设置

- (void)wxm_customDifferentInterface {
    
    
}

#pragma mark _________________________________ SET

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self wxm_customDifferentInterface];
}

/** 设置线条类型 */
- (void)wxm_setLineType:(WXMCommonTextFieldLineType)lineType {
    _lineType = lineType;
    CGFloat top = self.frame.size.height - 0.5;
    
    switch (lineType) {
        case WXMCommonTextFieldLineTypeNone:
            if (_line)[_line removeFromSuperlayer];
            if (_underLine)[_underLine removeFromSuperlayer];
            break;
            
        case WXMCommonTextFieldLineTypeTop:
            self.line.frame = CGRectMake(WXMCommonLineX, 0, WXMCommonW - WXMCommonLineX , 0.5);
            [self.layer addSublayer:self.line];
            if (_underLine)[_underLine removeFromSuperlayer];
            break;
            
        case WXMCommonTextFieldLineTypeBottom:
            if (_line)[_line removeFromSuperlayer];
            self.underLine.frame = CGRectMake(WXMCommonLineX, top, WXMCommonW-WXMCommonLineX,0.5);
            [self.layer addSublayer:self.underLine];
            break;
            
        case WXMCommonTextFieldLineTypeBoth:
            self.line.frame = CGRectMake(WXMCommonLineX, 0, WXMCommonW - WXMCommonLineX , 0.5);
            self.underLine.frame = CGRectMake(WXMCommonLineX, top, WXMCommonW-WXMCommonLineX,0.5);
            [self.layer addSublayer:self.line];
            [self.layer addSublayer:self.underLine];
            break;
            
        default: break;
    }
    
}

/** Switch回调避免过快点击 */
- (void)change:(UISwitch *)switchControl {
    if (_delegate && [_delegate respondsToSelector:@selector(wxm_commonCellSwitchState:)]) {
        [_delegate wxm_commonCellSwitchState:switchControl.on];
    }
    
    switchControl.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        switchControl.userInteractionEnabled = YES;
    });
}

#pragma mark _________________________________ GET

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:WXMCommonTitleFont];
        _titleLabel.textColor = WXMCommonTitleColor;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [UIFont systemFontOfSize:WXMCommonTitleFont];
        _detailLabel.textColor = WXMCommonTitleColor;
        _detailLabel.numberOfLines = 1;
    }
    return _detailLabel;
}

- (UILabel *)subDetailLabel {
    if (!_subDetailLabel) {
        _subDetailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:WXMCommonSubDetailFont];
        _detailLabel.textColor = WXMCommonSubDetailColor;
        _detailLabel.numberOfLines = 1;
    }
    return _subDetailLabel;
}

- (CALayer *)line {
    if (!_line) {
        _line = [[CALayer alloc] init];
        _line.frame = CGRectMake(WXMCommonLineX, 0, WXMCommonW - WXMCommonLineX , 0.5);
        _line.backgroundColor = WXMCommonLineColor.CGColor;
    }
    return _line;
}

- (CALayer *)underLine {
    if (!_underLine) {
        _underLine = [[CALayer alloc] init];
        _underLine.frame = CGRectMake(WXMCommonLineX, 0, WXMCommonW - WXMCommonLineX , 0.5);
        _underLine.backgroundColor = WXMCommonLineColor.CGColor;
    }
    return _underLine;
}

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] init];
    }
    return _arrowImage;
}

- (UIControl *)control {
    if (!_control) {
        _control = [[UIControl alloc] init];
    }
    return _control;
}

- (UISwitch *)switchControl {
    if (!_switchControl) {
        _switchControl = [[UISwitch alloc] init];
        UIControlEvents event = UIControlEventValueChanged;
        _switchControl = [[UISwitch alloc] init];
        _switchControl.frame = CGRectMake(0, 0, 80, self.frame.size.height);
        _switchControl.onTintColor = [UIColor blueColor];
        [_switchControl addTarget:self action:@selector(change:) forControlEvents:event];
    }
    return _switchControl;
}
@end
