//
//  WXMBaseTextFidleView.m
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//
#define WXMCommonW [UIScreen mainScreen].bounds.size.width
#import "WXMBaseTextFidleView.h"

@interface WXMBaseTextFidleView ()
@property (nonatomic, assign) WXMCommonTextFieldLineType lineType;
@end

@implementation WXMBaseTextFidleView

- (void)customDifferentInterface {
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self customDifferentInterface];
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
}

/** 设置线条类型 */
- (void)setLineType:(WXMCommonTextFieldLineType)lineType {
    _lineType = lineType;
    CGFloat h = 0.5;
    CGFloat top = self.frame.size.height - h;
    
    switch (lineType) {
        case WXMCommonTextFieldLineTypeNone:
            if (_line) [_line removeFromSuperlayer];
            if (_underLine) [_underLine removeFromSuperlayer];
            break;
            
        case WXMCommonTextFieldLineTypeTop:
            self.line.frame = CGRectMake(WXMCommonLineX, 0, WXMCommonW - WXMCommonLineX, h);
            [self.layer addSublayer:self.line];
            if (_underLine)[_underLine removeFromSuperlayer];
            break;
            
        case WXMCommonTextFieldLineTypeBottom:
            if (_line) [_line removeFromSuperlayer];
            self.underLine.frame = CGRectMake(WXMCommonLineX, top, WXMCommonW - WXMCommonLineX,h);
            [self.layer addSublayer:self.underLine];
            break;
            
        case WXMCommonTextFieldLineTypeBoth:
            self.line.frame = CGRectMake(WXMCommonLineX, 0, WXMCommonW - WXMCommonLineX, h);
            self.underLine.frame = CGRectMake(WXMCommonLineX, top, WXMCommonW-WXMCommonLineX, h);
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
        _detailLabel.font = [UIFont systemFontOfSize:WXMCommonDetailFont];
        _detailLabel.textColor = WXMCommonDetailColor;
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

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.textColor = WXMCommonTitleColor;
        _textField.inputAccessoryView = [UIView new];
        _textField.font = [UIFont systemFontOfSize:WXMCommonTitleFont];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
    }
    return _textView;
}

- (CALayer *)line {
    if (!_line) {
        _line = [[CALayer alloc] init];
        _line.frame = CGRectMake(WXMCommonLineX, 0, WXMCommonW - WXMCommonLineX , 0.75);
        _line.backgroundColor = WXMCommonLineColor.CGColor;
    }
    return _line;
}

- (CALayer *)underLine {
    if (!_underLine) {
        _underLine = [[CALayer alloc] init];
        _underLine.frame = CGRectMake(WXMCommonLineX, 0, WXMCommonW - WXMCommonLineX * 2, 0.5);
        _underLine.backgroundColor = WXMCommonLineColor.CGColor;
    }
    return _underLine;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
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

#pragma mark _________________________________textField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(wt_textFieldDidBeginEditing:)]) {
        [self.delegate wt_textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(wt_textFieldShouldClear:)]) {
        return [self.delegate wt_textFieldShouldClear:textField];
    }
    
    if ([self.delegate respondsToSelector:@selector(wt_textFieldValueChanged:)]) {
        [self.delegate wt_textFieldValueChanged:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(wt_textFieldShouldReturn:)]) {
        return [self.delegate wt_textFieldShouldReturn:textField];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) return YES;
    if (self.maxCharacter == 0) return YES;
    if (textField.text.length >= self.maxCharacter) return NO;
    return YES;
}

- (void)textFieldValueChanged:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(wt_textFieldValueChanged:)]) {
        [self.delegate wt_textFieldValueChanged:textField];
    }
}

#pragma mark _________________________________textView delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(wt_textViewDidBeginEditing:)]) {
        [self.delegate wt_textViewDidBeginEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) return YES;
    if (self.maxCharacter == 0) return YES;
    if (text.length >= self.maxCharacter) return NO;
    if([text isEqualToString:@"\n"]){
        if ([self.delegate respondsToSelector:@selector(wt_textViewShouldReturn:)]) {
            [self.delegate wt_textViewShouldReturn:textView];
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(wt_textViewValueChanged:)]) {
        [self.delegate wt_textViewValueChanged:textView];
    }
    
    /** 自适应高度 */
    if (self.adaptiveHeight) {
        CGRect selfFrame = self.frame;
        CGRect textViewFrame = textView.frame;
        CGFloat difference = selfFrame.size.height - textViewFrame.size.height;
                
        CGFloat textViewWidth = textView.frame.size.width;
        float textViewHeight = [textView sizeThatFits:CGSizeMake(textViewWidth, MAXFLOAT)].height;
        
        textViewFrame.size.height = textViewHeight;
        selfFrame.size.height = textViewHeight + difference;
        textView.frame = textViewFrame;
        self.frame = selfFrame;
    }
}
@end
