//
//  WXMBaseReplaceMacro.h
//  Multi-project-coordination
//
//  Created by wq on 2020/4/11.
//  Copyright © 2020 wxm. All rights reserved.
//

#ifndef WXMBaseReplaceMacro_h
#define WXMBaseReplaceMacro_h

@protocol WXMHandlerProtocol <NSObject>
@optional;
+ (instancetype)handlerImp;
+ (instancetype (^)(id delegate))singletonhandler;
@end

#endif /* WXMBaseReplaceMacro_h */
#define handlerImp singletonhandler(self)
