//
//  WXMCommonBaseCustomView.h
//  ModuleDebugging
//
//  Created by edz on 2019/6/17.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMCommonBaseTextFidleView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WXMCommonCustomViewDelegate <NSObject>

/** Switch状态改变 */
- (void)wxm_commonCellSwitchState:(BOOL)isOpen;

@optional

@end

@interface WXMCommonBaseCustomView : UIView
@property (nonatomic, strong) CALayer *line;
@property (nonatomic, strong) CALayer *underLine;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *subDetailLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, weak) id<WXMCommonCustomViewDelegate> delegate;

/** 自定义配置 */
- (void)wxm_customDifferentInterface;

/** 设置线条类型 */
- (void)wxm_setLineType:(WXMCommonTextFieldLineType)lineType;

@end

NS_ASSUME_NONNULL_END
