//
//  WXMStatusView.m
//  Demo2
//
//  Created by wq on 2019/4/29.
//  Copyright © 2019年 wq. All rights reserved.
//
#define WXM_SWidth [UIScreen mainScreen].bounds.size.width
#define WXM_SHeight [UIScreen mainScreen].bounds.size.height
#import "WXMErrorStatusView.h"

@implementation WXMErrorStatusView

+ (WXMErrorStatusView *)wxm_errorsViewWithType:(WXMErrorStatusType)type {
    WXMErrorStatusView *statusView = [WXMErrorStatusView new];
    statusView.errorType = type;
    statusView.tag = WXM_ErrorSign;
    [statusView setupInterface];
    return statusView;
}

- (void)setupInterface {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = WXM_BackgroundColor;
    
    UIImage *image = self.currentImage;
    CGFloat oldWidth = image.size.width;
    if (oldWidth > (WXM_SWidth - 120)) oldWidth = WXM_SWidth - 120;
    CGFloat imgHeight = (image.size.height / image.size.width) * oldWidth;
    
    /** 自定义图片大小 */
    if (CGSizeEqualToSize(WXM_IMGSize, CGSizeZero) == NO) {
        oldWidth = WXM_IMGSize.width;
        imgHeight = WXM_IMGSize.height;
    }
    _erroeImgVC = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,oldWidth, imgHeight)];
    _erroeImgVC.image = image;
    
    _errorMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _errorMsg.textAlignment = NSTextAlignmentCenter;
    _errorMsg.text = self.currentMessage;
    _errorMsg.font = [UIFont systemFontOfSize:14];
    _errorMsg.textColor = WXM_TextColor;
    _errorMsg.numberOfLines = 1;
    
    [self wxm_modifyCoordinate];
    [self addSubview:_erroeImgVC];
    [self addSubview:_errorMsg];
}

/** 更新frame */
- (void)wxm_modifyCoordinate {
    [_errorMsg sizeToFit];
    if (!self.superview) return;
    CGFloat selfWidth = self.superview.frame.size.width;
    CGFloat centX = selfWidth / 2;
    
    _erroeImgVC.center = CGPointMake(centX, _erroeImgVC.center.y);
    _errorMsg.center = CGPointMake(centX, _errorMsg.center.y);
    CGFloat superH = self.superview.frame.size.height;
    CGFloat minH = WXM_MinH + _erroeImgVC.frame.size.height + _errorMsg.frame.size.height;
    CGFloat realH = MAX(minH, superH);
    CGFloat blank = realH - _erroeImgVC.frame.size.height - _errorMsg.frame.size.height;
    CGFloat top = (blank - 10) / 2.0 - (realH == superH ? (superH >= (WXM_SHeight - 64 ) ? 44 : 15) : 5);
    CGRect imgFrame = _erroeImgVC.frame;
    CGRect msgFrame = _errorMsg.frame;
    imgFrame.origin.y = top;
    msgFrame.origin.y = top + imgFrame.size.height;
    _erroeImgVC.frame = imgFrame;
    _errorMsg.frame = msgFrame;
    self.frame = CGRectMake(0, 0, selfWidth, realH);
}

/** 图片 */
- (UIImage *)currentImage {
    NSString * imageName = @"";
    switch (self.errorType) {
        case WXMErrorStatusTypeNormal:imageName = @""; break;
        case WXMErrorStatusTypeBadNetwork:imageName = @"ic_default4"; break;
        case WXMErrorStatusTypeNorecord: imageName = @"ic_default1";  break;
        case WXMErrorStatusTypeRequestFail: imageName = @"ic_default2";  break;
        default: break;
    }
    return [UIImage imageNamed:imageName] ?: nil;
}

/** 提示内容 */
- (NSString *)currentMessage {
    NSString * messsage = @"";
    switch (self.errorType) {
        case WXMErrorStatusTypeNormal:messsage = @""; break;
        case WXMErrorStatusTypeBadNetwork:messsage = @"网络异常"; break;
        case WXMErrorStatusTypeNorecord: messsage = @"暂无更多记录";  break;
        case WXMErrorStatusTypeRequestFail: messsage = @"数据加载失败"; break;
        default: break;
    }
    return messsage;
}

/** 设置类型 */
- (void)setErrorType:(WXMErrorStatusType)errorType {
    _errorType = errorType;
    _erroeImgVC.image = self.currentImage;
    _errorMsg.text = self.currentMessage;
    if (errorType == WXMErrorStatusTypeNormal) [self removeFromSuperview];
    [self wxm_modifyCoordinate];
}

- (CGFloat)minHeight {
    return WXM_MinH + _erroeImgVC.frame.size.height + _errorMsg.frame.size.height;
}
- (void)didMoveToSuperview {
    if (self.superview) [self wxm_modifyCoordinate];
}
@end
