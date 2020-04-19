//
//  WXMBaseButtonView.m
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import "WXMBaseThemeButton.h"

@implementation WXMBaseThemeButton

/** 主题 */
+ (WXMBaseThemeButton *)themeButtonWithTitle:(NSString *)title {
    WXMBaseThemeButton *themeButton = [WXMBaseThemeButton new];
    [themeButton setTitle:title forState:UIControlStateNormal];
    [themeButton setDefaultThemeInterface];
    return themeButton;
}

+ (WXMBaseThemeButton *)themeButtonDisabledWithTitle:(NSString *)title {
    WXMBaseThemeButton *themeButton = [WXMBaseThemeButton new];
    [themeButton setTitle:title forState:UIControlStateNormal];
    [themeButton setDefaultThemeInterface];
    themeButton.enabled = NO;
    return themeButton;
}

- (void)setDefaultThemeInterface {
    CGRect frame = (CGRect){WXMThemeMargin, 0, WXMCommonWidth - 2 * WXMThemeMargin, WXMThemeHeight};
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
    
}

/** 设置title */
- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

/** 设置背景色 */
- (void)setBackgroundColor:(UIColor *)color {
    [self setBackgroundColor:color forState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    [self setBackgroundImage:[self imageFromColor:color] forState:state];
}

/** 设置字体色 */
- (void)setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [super setTitleColor:color forState:state];
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
