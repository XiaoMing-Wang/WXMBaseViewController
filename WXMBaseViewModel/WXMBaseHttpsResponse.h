//
//  WXMBaseHttpsResp.h
//  WXMComponentization
//
//  Created by sdjim on 2020/4/7.
//  Copyright © 2020 sdjim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXMBaseHttpsResponse : NSObject

/** 成功失败 */
@property (nonatomic, assign) BOOL success;

/** 状态码 */
@property (nonatomic, assign) NSInteger errorCode;

/** 错误信息 */
@property (nonatomic, assign) NSInteger errormMessage;

/** 传递对象 */
@property (nonatomic, assign) id errorObject;

/** 返回的数组 */
@property (nonatomic, assign) NSDictionary *errorArray;

/** 返回的参数 */
@property (nonatomic, assign) NSDictionary *errorResults;

@end

NS_ASSUME_NONNULL_END
