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
+ (instancetype)handImp;
+ (instancetype (^)(id delegate))singletonhandler;
@end

#endif /* WXMBaseReplaceMacro_h */
#define handImp singletonhandler(self)
#define SINGLETON_HANDLE_CLASS(CLASS) + (CLASS * (^)(id delegate))singletonhandler;
#define IMPLEMENTATION_CLASS(CLASS)   @implementation CLASS @end
#define NO_PARAMETER_NIL(parameter)   if (!parameter) return;

