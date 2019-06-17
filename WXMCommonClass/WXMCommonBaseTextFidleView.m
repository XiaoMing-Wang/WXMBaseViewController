//
//  WXMBaseTextFidleView.m
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//
#define WXMCommonW [UIScreen mainScreen].bounds.size.width
#import "WXMCommonBaseTextFidleView.h"

@interface WXMCommonBaseTextFidleView ()
@property (nonatomic, assign) WXMCommonTextFieldLineType lineType;
@end

@implementation WXMCommonBaseTextFidleView

#pragma mark _________________________________ 自定义类型UI设置

- (void)wxm_customDifferentInterface {
    
    
}


#pragma mark _________________________________ SET

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self wxm_customDifferentInterface];
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self.textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
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

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.textColor = WXMCommonTitleColor;
        _textField.font = [UIFont systemFontOfSize:WXMCommonTitleFont];
        [_textField setValue:WXMCommonPlaceColor forKeyPath:@"_placeholderLabel.textColor"];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
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

- (UIButton *)commonButton {
    if (!_commonButton) {
        _commonButton = [[UIButton alloc] init];
    }
    return _commonButton;
}

#pragma mark _________________________________textField delegate

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(wxm_textFieldShouldClear:)]) {
        return [self.delegate wxm_textFieldShouldClear:textField];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(wxm_textFieldValueChanged:)]) {
        [_delegate wxm_textFieldValueChanged:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(wxm_textFieldShouldReturn:)]) {
        return [_delegate wxm_textFieldShouldReturn:textField];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.maxCharacter == 0) return YES;
    if (textField.text.length >= self.maxCharacter) return NO;
    return YES;
}

- (void)textFieldValueChanged:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(wxm_textFieldValueChanged:)]) {
        [_delegate wxm_textFieldValueChanged:textField];
    }
}
@end
