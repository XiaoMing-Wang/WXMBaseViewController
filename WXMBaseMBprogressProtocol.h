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

/** 显示hud并且关闭手势  */
- (void)wxm_showLoadingForbid;
- (void)wxm_hideLoadingForbid;

/** 成功图标 */
- (void)wxm_showSuccessHud:(NSString *)wxm_msg;
- (void)wxm_showSuccessHud:(NSString *)wxm_msg afterDelay:(NSTimeInterval)wxm_delay;

- (void)wxm_showMBProgressMessage:(NSString *)wxm_message;       /** 显示文字在导航控制器上  */
- (void)wxm_showMBProgressMessageSelfVC:(NSString *)wxm_message; /** 显示文字在当前控制器  */
- (void)wxm_hideMBProgressText;                                 /** 隐藏文  */
- (void)wxm_hideMBProgressAllText;                              /** 隐藏所有  */


@end

NS_ASSUME_NONNULL_END
