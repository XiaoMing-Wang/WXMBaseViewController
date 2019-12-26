//
//  WXMCommonBaseCustomView.h
//  ModuleDebugging
//
//  Created by edz on 2019/6/17.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMBaseTextFidleView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WXMCustomViewDelegate <NSObject>

/** Switch状态改变 */
- (void)wt_commonCellSwitchState:(BOOL)isOpen;

@optional

@end

@interface WXMBaseCustomView : UIView
@property (nonatomic, strong) CALayer *line;
@property (nonatomic, strong) CALayer *underLine;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *subDetailLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, weak) id<WXMCustomViewDelegate> delegate;

/** 自定义配置 */
- (void)customDifferentInterface;

/** 设置线条类型 */
- (void)setLineType:(WXMCommonTextFieldLineType)lineType;

@end

NS_ASSUME_NONNULL_END
