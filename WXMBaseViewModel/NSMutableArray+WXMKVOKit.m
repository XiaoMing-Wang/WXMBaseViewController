//
//  NSMutableArray+YDKVOKit.m
//  YDOverseasUI
//
//  Created by edz on 2019/5/29.
//
#import <objc/runtime.h>
#import "NSMutableArray+WXMKVOKit.h"

static char observerKey;
static char propertyKey;
@implementation NSMutableArray (WXMKVOKit)

- (BOOL)wxm_presenceListener {
    id observer = objc_getAssociatedObject(self, &observerKey);
    NSString *proper = objc_getAssociatedObject(self, &propertyKey);
    return (observer && proper);
}

+ (NSMutableArray *)wxm_addArrayWithObserver:(id)observer selector:(SEL)sel {
    NSMutableArray *arrays = [NSMutableArray array];
    @try {
        NSString *proper = NSStringFromSelector(sel);
        objc_setAssociatedObject(arrays, &observerKey, observer, OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(arrays, &propertyKey, proper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } @catch (NSException *exception) {} @finally {};
    return arrays;
}

- (void)wxm_setObserver:(id)observer selector:(SEL)sel {
    @try {
        NSString *proper = NSStringFromSelector(sel);
        objc_setAssociatedObject(self, &observerKey, observer, OBJC_ASSOCIATION_ASSIGN);
        objc_setAssociatedObject(self, &propertyKey, proper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } @catch (NSException *exception) {} @finally {};
}

- (void)wxm_addObject:(id)anObject {
    if (!anObject) return;
    [self wxm_listeningObserver:^{
        [self addObject:anObject];
    }];
}

- (void)wxm_addObjectsFromArray:(NSArray *)otherArray {
    if (!otherArray.count) return;
    [self wxm_listeningObserver:^{
        [self addObjectsFromArray:otherArray];
    }];
}

- (void)wxm_removeLastObject {
    [self wxm_listeningObserver:^{
        [self removeLastObject];
    }];
}

- (void)wxm_removeAllObjects {
    [self wxm_listeningObserver:^{
        [self removeAllObjects];
    }];
}

- (void)wxm_removeObjectAtIndex:(NSUInteger)index {
    [self wxm_listeningObserver:^{
        [self removeObjectAtIndex:index];
    }];
}

- (void)wxm_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self wxm_listeningObserver:^{
        [self replaceObjectAtIndex:index withObject:anObject];
    }];
}

- (void)wxm_setArray:(NSArray *)otherArray {
    [self wxm_listeningObserver:^{
        [self removeAllObjects];
        [self addObjectsFromArray:otherArray];
    }];
}

- (void)wxm_replaceArray:(NSArray *)otherArray {
    [self wxm_listeningObserver:^{
        [self removeAllObjects];
        [self addObjectsFromArray:otherArray];
    }];
}

- (void)wxm_listeningObserver:(void(^)(void))result {
    id observer = objc_getAssociatedObject(self, &observerKey);
    NSString *proper = objc_getAssociatedObject(self, &propertyKey);
    if (!observer || !proper) {
        if (result) result();
        return;
    }
    
    [observer willChangeValueForKey:proper];
    if (result) result();
    [observer didChangeValueForKey:proper];
}
@end
