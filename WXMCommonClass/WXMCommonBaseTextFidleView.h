//
//  WXMBaseTextFidleView.h
//  Multi-project-coordination
//
//  Created by wq on 2019/6/16.
//  Copyright © 2019年 wxm. All rights reserved.
//
#define WXMCommonLineX 16
#define WXMCommonTitleFont 16
#define WXMCommonTitleColor [UIColor blackColor]
#define WXMCommonPlaceColor [UIColor lightGrayColor]
#define WXMCommonLineColor [UIColor grayColor]

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol WXMCommonTextFieldDelegate <NSObject>
@optional
- (BOOL)wxm_textFieldShouldClear:(UITextField *)textField;
- (BOOL)wxm_textFieldShouldReturn:(UITextField *)textField;
- (void)wxm_textFieldValueChanged:(UITextField *)textField;
@end

/** 线条类型 */
typedef NS_ENUM(NSUInteger, WXMCommonTextFieldLineType) {
    WXMCommonTextFieldLineTypeNone = 0,
    WXMCommonTextFieldLineTypeTop,
    WXMCommonTextFieldLineTypeBottom,
    WXMCommonTextFieldLineTypeBoth,
};

@interface WXMCommonBaseTextFidleView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) CALayer *line;
@property (nonatomic, strong) CALayer *underLine;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIControl *control;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) NSInteger maxCharacter;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, weak) id<WXMCommonTextFieldDelegate> delegate;

/** 自定义配置 */
- (void)wxm_customDifferentInterface;

/** 设置线条类型 */
- (void)wxm_setLineType:(WXMCommonTextFieldLineType)lineType;

@end

NS_ASSUME_NONNULL_END
