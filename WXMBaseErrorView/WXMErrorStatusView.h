//
//  WXMStatusView.h
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.

#import <UIKit/UIKit.h>
#import "UIView+WXMErrorStatusView.h"

@interface WXMErrorStatusView : UIControl
@property (nonatomic, assign) WXMErrorStatusType errorType;
@property (nonatomic, strong) UIImageView *erroeImgVC;
@property (nonatomic, strong) UILabel *errorMsg;
- (CGFloat)minHeight;
+ (WXMErrorStatusView *)wxm_errorsViewWithType:(WXMErrorStatusType)type;
@end
