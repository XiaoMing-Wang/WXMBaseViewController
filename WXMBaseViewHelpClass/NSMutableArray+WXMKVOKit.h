//
//  NSMutableArray+WXMKVOKit.h
//  WXMOverseasUI
//
//  Created by edz on 2019/5/29.
//
/** kvo的方式触发数组变动 */
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (WXMKVOKit)

- (BOOL)wxm_presenceListener;
+ (NSMutableArray *)wxm_addArrayWithObserver:(id)observer selector:(SEL)sel;
- (void)wxm_setObserver:(id)observer selector:(SEL)sel;

/** 添加 */
- (void)wxm_addObject:(id)anObject;
- (void)wxm_addObjectsFromArray:(NSArray *)otherArray;

- (void)wxm_removeLastObject;
- (void)wxm_removeAllObjects;
- (void)wxm_removeObjectAtIndex:(NSUInteger)index;

/** 替换 */
- (void)wxm_setArray:(NSArray *)otherArray;
- (void)wxm_replaceArray:(NSArray *)otherArray;

@end

NS_ASSUME_NONNULL_END
