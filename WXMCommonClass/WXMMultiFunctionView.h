//
//  WXMMultiFunctionView.h
//  ModuleDebugging
//
//  Created by edz on 2019/6/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXMMultiFunctionView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *mainIconView;
@property (nonatomic, strong) UIImageView *detailIconView;
@end

NS_ASSUME_NONNULL_END
