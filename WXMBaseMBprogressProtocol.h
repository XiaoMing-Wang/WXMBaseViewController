//
//  WXMBaseMBprogressProtocol.h
//  MultiProject_Coordination
//
//  Created by edz on 2019/5/31.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WXMBaseMBprogressProtocol <NSObject>
@optional
- (void)wxm_showLoadingImage;       /** 加载动图 可以交互 */
- (void)wxm_showLoadingImageFull;   /** 禁止交互(全屏)wxm_ */
- (void)wxm_showLoadingImage_noInf; /** 禁止交互(非全屏)wxm_  */
- (void)wxm_hideLoadingImage;       /** 隐藏动图  */
- (void)wxm_showLoadingForbid;
- (void)wxm_hideLoadingForbid;
@end

NS_ASSUME_NONNULL_END
