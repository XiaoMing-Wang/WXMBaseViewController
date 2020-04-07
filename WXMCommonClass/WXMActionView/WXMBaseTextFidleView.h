//
//  WXMBaseTextFidleView.h
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMActionCconfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WXMCommonTextFieldDelegate <NSObject>
@optional
- (void)wt_textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)wt_textFieldShouldClear:(UITextField *)textField;
- (BOOL)wt_textFieldShouldReturn:(UITextField *)textField;
- (void)wt_textFieldValueChanged:(UITextField *)textField;

- (void)wt_textViewDidBeginEditing:(UITextView *)textView;
- (BOOL)wt_textViewShouldReturn:(UITextView *)textView;
- (void)wt_textViewValueChanged:(UITextView *)textView;
@end

@interface WXMBaseTextFidleView : UIView <UITextFieldDelegate, UITextViewDelegate>

/** 上下线条 */
@property (nonatomic, strong) CALayer *line;
@property (nonatomic, strong) CALayer *underLine;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *subDetailLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIControl *control;

/** textView自适应高度 */
@property (nonatomic, assign) BOOL adaptiveHeight;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) NSInteger maxCharacter;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, weak) id<WXMCommonTextFieldDelegate> delegate;

/** 自定义配置 */
- (void)customDifferentInterface;

/** 设置线条类型 */
- (void)setLineType:(WXMCommonTextFieldLineType)lineType;

@end

NS_ASSUME_NONNULL_END
