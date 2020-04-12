//
//  WXMBaseHttpsResp.m
//  WXMComponentization
//
//  Created by sdjim on 2020/4/7.
//  Copyright © 2020 sdjim. All rights reserved.
//

#import "WXMBaseHttpsResponse.h"

@implementation WXMBaseHttpsResponse

- (instancetype)init {
    if (self = [super init]) self.errorCode = -1;
    return self;
}

- (BOOL)success {
    return (self.errorCode == 0 && self);
}


@end
