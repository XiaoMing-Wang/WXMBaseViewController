//
//  WXMBaseNetworkHandler.m
//  WXMComponentization
//
//  Created by sdjim on 2020/4/2.
//  Copyright © 2020 sdjim. All rights reserved.
//

#import "WXMBaseNetworkHandler.h"

@implementation WXMBaseHttpsResp

- (BOOL)success {
    return (self.errorCode == 0 && self);
}

@end

@implementation WXMBaseHttpsReq

@end

@implementation WXMBaseNetworkHandler

@end
