//
//  WXMBaseButtonView.m
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseThemeButton.h"

@interface WXMBaseThemeButton ()
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, copy) NSString *signTitle;
@end

@implementation WXMBaseThemeButton

/** 主题 */
+ (WXMBaseThemeButton *)themeButtonWithTitle:(NSString *)title {
    WXMBaseThemeButton *themeButton = [WXMBaseThemeButton new];
    [themeButton setTitle:title forState:UIControlStateNormal];
    [themeButton setDefaultThemeInterface];
    return themeButton;
}

+ (WXMBaseThemeButton *)themeButtonDisabledWithTitle:(NSString *)title {
    WXMBaseThemeButton *themeButton = [self themeButtonWithTitle:title];
    themeButton.enabled = NO;
    return themeButton;
}

- (void)setDefaultThemeInterface {
    CGRect frame = (CGRect){WXMThemeMargin,0,WXMCommonWidth-2*WXMThemeMargin,WXMThemeHeight};
    UIImage *backgroundImage = [self imageFromColor:WXMThemeBackgroundColor];
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self setTitleColor:WXMThemetTitleColor forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:WXMThemeFontSize];
    self.layer.cornerRadius = WXMThemeCornerRadius;
    self.layer.masksToBounds = YES;
    [self setFrame:frame];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self customDifferentInterface];
}

/** 自定义配置 */
- (void)customDifferentInterface {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.indicator.center = CGPointMake(width / 2, height / 2);
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    [self setBackgroundImage:[self imageFromColor:color] forState:state];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [self setTitleColor:color forState:state];
}

- (void)setButtonState:(WXMStateButtonState)buttonState {
    _buttonState = buttonState;
    self.enabled = YES;
    self.userInteractionEnabled = YES;
    
    if (_buttonState == WXMStateButtonStateNormal) {
        [self.indicator stopAnimating];
        if (self.signTitle.length > 0) {
            [self setTitle:self.signTitle forState:UIControlStateNormal];
        }
    } else if (_buttonState == WXMStateButtonStateDisabled) {
        self.enabled = NO;
    } else if (_buttonState == WXMStateButtonStateLoading)  {
        self.userInteractionEnabled = NO;
        self.signTitle = self.titleLabel.text;
        [self.indicator startAnimating];
        [self addSubview:self.indicator];
    }
    [self customDifferentInterface];
}

- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] init];
        _indicator.hidesWhenStopped = YES;
        [_indicator startAnimating];
    }
    return _indicator;
}

/** 根据颜色绘制图片 */
- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end