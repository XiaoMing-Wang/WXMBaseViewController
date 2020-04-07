//
//  WXMBaseNetworkHandler.h
//  WXMComponentization
//
//  Created by sdjim on 2020/4/2.
//  Copyright © 2020 sdjim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXMBaseHttpsResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXMBaseHttpsReq : NSObject
@end

@interface WXMBaseNetworkHandler : NSObject
@property (nonatomic, strong) WXMBaseHttpsReq *httpReq;
@end

NS_ASSUME_NONNULL_END
