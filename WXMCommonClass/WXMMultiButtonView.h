//
//  WXMMultiFunctionView.h
//  ModuleDebugging
//
//  Created by edz on 2019/6/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WXMMultiButtonType) {
    WXMMultiButtonTypeImageMassage = 0,
    WXMMultiButtonTypeReserved,
};

@interface WXMMultiButtonView : UIButton

@property (nonatomic, strong) UILabel *titlesLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *lordimageView;
@property (nonatomic, strong) UIImageView *detaimagelView;

@property (nonatomic, strong) UIImage *lordiImage;
@property (nonatomic, strong) NSString *titleString;

@property (nonatomic, assign) CGSize lordiImageSize;
@property (nonatomic, assign) CGFloat lordiImageOffset;
@property (nonatomic, assign) CGFloat interval;
@property (nonatomic, assign) WXMMultiButtonType multiButtonType;

+ (WXMMultiButtonView *)multiButtonViewWithType:(WXMMultiButtonType)multiButtonType;

@end

NS_ASSUME_NONNULL_END
