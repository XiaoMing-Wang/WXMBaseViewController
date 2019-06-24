//
//  WXMMultiFunctionView.h
//  ModuleDebugging
//
//  Created by edz on 2019/6/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN




@interface WXMMultiButtonView : UIButton

@property (nonatomic, strong) UILabel *titlesLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *mainIconView;
@property (nonatomic, strong) UIImageView *detailIconView;
@end

NS_ASSUME_NONNULL_END
