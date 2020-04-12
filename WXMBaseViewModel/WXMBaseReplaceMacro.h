//
//  WXMBaseReplaceMacro.h
//  Multi-project-coordination
//
//  Created by wq on 2020/4/11.
//  Copyright © 2020 wxm. All rights reserved.
//

#ifndef WXMBaseReplaceMacro_h
#define WXMBaseReplaceMacro_h

/** 初始化的宏 */
#define handler singletonhandler(self)

/** iphoneX */
//#define handler new[self]
//({ handler[@"aaa"] = self; \
//if (@available(iOS 11.0, *)) {\
//isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
//}\
//(isPhoneX);\
//})


#endif /* WXMBaseReplaceMacro_h */
