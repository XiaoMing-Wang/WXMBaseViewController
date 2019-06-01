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

@interface WXMErrorStatusView ()
@property(nonatomic, strong) UIActivityIndicatorView *refrshIndicator;
@end

@implementation WXMErrorStatusView

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

+ (WXMErrorStatusView *)wxm_errorsViewWithType:(WXMErrorStatusType)type {
    return [self wxm_errorsViewWithType:type interfaceType:WXMErrorFaceTypeDefault];
}
+ (WXMErrorStatusView *)wxm_errorsViewWithType:(WXMErrorStatusType)type
                                 interfaceType:(WXMErrorStatusInterfaceType)interfaceType {
    if (type == WXMErrorStatusTypeNormal) return nil;
    WXMErrorStatusView *statusView = [WXMErrorStatusView new];
    statusView.errorType = type;
    statusView.interfaceType = interfaceType;
    statusView.tag = WXM_ErrorSign;
    [statusView setupInterface];
    return statusView;
}

/**  */
- (void)setupInterface {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = WXM_BackgroundColor;
    
    if (self.errorType == WXMErrorStatusTypeRequestLoading) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:2];
    /** _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite; */
        [_indicatorView startAnimating];
        [self addSubview:_indicatorView];
        [self wxm_modifyCoordinate];
        
    } else {
        
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
        
        _refreshControl = [[UIButton alloc] init];
        _refreshControl.frame = CGRectMake(0, 0, 0, 45);
        [_refreshControl setBackgroundColor:WXM_RefreshBgcolor];
        [_refreshControl setTitleColor:WXM_RefreshTextcolor forState:UIControlStateNormal];
        [_refreshControl setTitle:WXM_RefreshText forState:UIControlStateNormal];
        _refreshControl.layer.cornerRadius = WXM_RefreshCornerRadius;
        _refreshControl.titleLabel.font = [UIFont systemFontOfSize:16];
        _refreshControl.hidden = (_interfaceType != WXMErrorFaceTypeRefresh);
        SEL sel = @selector(wxm_touchUpInside);
        [_refreshControl addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        
        _refrshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:2];
        _refrshIndicator.hidesWhenStopped = YES;
        _refrshIndicator.hidden = YES;
        _refrshIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        
        [self addSubview:_erroeImgVC];
        [self addSubview:_errorMsg];
        [self addSubview:_refreshControl];
        [self addSubview:_refrshIndicator];
        [self wxm_modifyCoordinate];
    }
}

/** 更新frame */
- (void)wxm_modifyCoordinate {
    if (!self.superview) return;
    CGFloat superWidth = self.superview.frame.size.width;
    CGFloat superHeight = self.superview.frame.size.height;
    
    if (self.errorType == WXMErrorStatusTypeRequestLoading) {
        self.frame = CGRectMake(0, 0, superWidth, superHeight);
        self.indicatorView.center = CGPointMake(superWidth / 2, superHeight / 2);
        [self.indicatorView startAnimating];
        
    } else if (self.errorType == WXMErrorStatusTypeNormal) {  return;
    } else {
        BOOL refresh = (self.interfaceType == WXMErrorFaceTypeRefresh);
        [_errorMsg sizeToFit];
        _erroeImgVC.center = CGPointMake(superWidth / 2, _erroeImgVC.center.y);
        _errorMsg.center = CGPointMake(superWidth / 2, _errorMsg.center.y);
        _refrshIndicator.center = CGPointMake(superWidth / 2, 0);
        
        CGFloat refresH = refresh ? 45 + 15 : 0;
        CGFloat minH = WXM_MinH + _erroeImgVC.frame.size.height + _errorMsg.frame.size.height + refresH;
        CGFloat realH = MAX(minH, superHeight);
        
        CGFloat blank = realH - _erroeImgVC.frame.size.height - _errorMsg.frame.size.height - refresH;
        CGFloat top = (blank - 10) / 2.0 + WXM_Offset;
        if (_interfaceType == WXMErrorFaceTypeRefresh) top = (blank - 10) / 2.0 + WXM_OffsetRefresh;
        CGRect imgFrame = _erroeImgVC.frame;
        CGRect msgFrame = _errorMsg.frame;
        CGRect refreshFrame = _refreshControl.frame;
        CGRect icatorFrame = _refrshIndicator.frame;
        
        imgFrame.origin.y = top;
        msgFrame.origin.y = top + imgFrame.size.height;
        refreshFrame.origin.y = msgFrame.origin.y + msgFrame.size.height + 25;
        refreshFrame.origin.x = WXM_RefreshMargin;
        refreshFrame.size.width = superWidth - 2 * WXM_RefreshMargin;
        icatorFrame.origin.y = refreshFrame.origin.y;
        
        _erroeImgVC.frame = imgFrame;
        _errorMsg.frame = msgFrame;
        if (refresh) _refreshControl.frame = refreshFrame;
        if (_refrshIndicator) _refrshIndicator.frame = icatorFrame;
        self.frame = CGRectMake(0, 0, superWidth, realH);
    }
}

/** 刷新开始 */
- (void)wxm_refreshControlStartAnimation {
    if (self.interfaceType == WXMErrorFaceTypeDefault) {
        [_refrshIndicator startAnimating];
        _refrshIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_refrshIndicator];
        
    } else if (self.interfaceType == WXMErrorFaceTypeRefresh) {
        [_refreshControl setTitle:@"" forState:UIControlStateNormal];
        [_refrshIndicator startAnimating];
        [_refreshControl addSubview:_refrshIndicator];
        _refreshControl.userInteractionEnabled = NO;
        
        CGFloat w = _refreshControl.frame.size.width;
        CGFloat h = _refreshControl.frame.size.height;
        _refrshIndicator.center = CGPointMake(w / 2, h / 2);
    }
}

/** 结束刷新 */
- (void)wxm_refreshControlStopAnimation:(BOOL)success {
    if (success) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {  [self removeFromSuperview]; }];
    } else {
        _refreshControl.userInteractionEnabled = YES;
        [_refrshIndicator removeFromSuperview];
        [_refreshControl setTitle:WXM_RefreshText forState:UIControlStateNormal];
    }
}

/** 全屏刷新 */
- (void)setFullScreenRefresh:(BOOL)fullScreenRefresh {
    _fullScreenRefresh = fullScreenRefresh;
    if (self.interfaceType == WXMErrorFaceTypeRefresh) return;
    SEL sel = @selector(wxm_touchUpInside);
    if (fullScreenRefresh) {
        [self addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self removeTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}

/**  */
- (void)wxm_addTarget:(id)target selector:(SEL)sel {
    if (self.interfaceType == WXMErrorFaceTypeDefault) {
        [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }else if (self.interfaceType == WXMErrorFaceTypeRefresh) {
        [_refreshControl addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}

/** */
- (void)wxm_touchUpInside {
    if (self.callBack) self.callBack();
    [self wxm_refreshControlStartAnimation];
}

/** 设置类型 */
- (void)setErrorType:(WXMErrorStatusType)errorType {
    _errorType = errorType;
    _erroeImgVC.image = self.currentImage;
    _errorMsg.text = self.currentMessage;
    if (errorType == WXMErrorStatusTypeNormal) {
        [self removeFromSuperview];
        return;
    }
    [self wxm_modifyCoordinate];
}

+ (CGFloat)minHeightWithType:(WXMErrorStatusInterfaceType)interfaceType {
    BOOL refresh = (interfaceType == WXMErrorFaceTypeRefresh);
    CGFloat incremental = refresh ? 60 : 0;
    if (CGSizeEqualToSize(WXM_IMGSize, CGSizeZero) == NO) {
        return WXM_MinH + WXM_IMGSize.height + 20 + incremental;
    }
    return WXM_MinH + ((WXM_SWidth - 120) * 1.1) + 20 + incremental;
}

- (void)didMoveToSuperview {
    if (self.superview) [self wxm_modifyCoordinate];
}
@end
