//
//  WXMBaseNetworkHandler.h
//  WXMComponentization
//
//  Created by sdjim on 2020/4/2.
//  Copyright © 2020 sdjim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WXMBaseHttpsResp;
typedef void (^NetworkHandlerCallBack)(WXMBaseHttpsResp *resp);
@interface WXMBaseHttpsResp : NSObject
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, assign) NSInteger errormMessage;
@property (nonatomic, assign) id errorObject;
@property (nonatomic, assign) NSDictionary *errorResults;
@end

@interface WXMBaseHttpsReq : NSObject
@end

@interface WXMBaseNetworkHandler : NSObject
@property (nonatomic, strong) WXMBaseHttpsReq *bodyReq;
@end

NS_ASSUME_NONNULL_END
