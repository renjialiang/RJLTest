//
//  RunTimeObjectOne.m
//  RJLTestPro
//
//  Created by admin on 17/4/17.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "RunTimeObjectOne.h"
#import "RuntimeObjcTest.h"
#import <objc/runtime.h>

@interface RunTimeObjectOne ()

{
    RuntimeObjcTest *_objcTest;
}

@end

@implementation RunTimeObjectOne

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _objcTest = [[RuntimeObjcTest alloc] init];
    }
    return self;
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    //考虑 self 作为类对象时 [self class] 返回值为自身实例   object_getClass(self)返回的是RunTimeObjectOne 元类对象 == object_getClass([self class])
    if (sel == @selector(learnRuntimeClass:))
    {
        class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(myClassMethod:)), "v@:");
        return YES;
    }
    return [class_getSuperclass(self) resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    //self 为实例对象 [self class] object_getClass(self)等价, 而object_getClass([self class])得到元类
    if (sel == @selector(goToSchool:))
    {
        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(myInstanceMethod:)), "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

+ (void)myClassMethod:(NSString *)string
{
    NSLog(@"myClassMethod = %@", string);
}

- (void)myInstanceMethod:(NSString *)string
{
    NSLog(@"myInstanceMethod = %@", string);
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(mysteriousMethod:))
    {
        return _objcTest;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([_objcTest respondsToSelector:[anInvocation selector]])
    {
        [anInvocation invokeWithTarget:_objcTest];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature)
    {
        signature = [_objcTest methodSignatureForSelector:aSelector];
    }
    return signature;
}

@end
