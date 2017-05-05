//
//  RuntimeObjcTest.m
//  RJLTestPro
//
//  Created by admin on 17/3/16.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "RuntimeObjcTest.h"
#import <objc/runtime.h>
static NSMutableDictionary *map = nil;
@implementation RuntimeObjcTest
+ (void)load
{
    map = [NSMutableDictionary dictionary];
    map[@"name1"] = @"name";
    map[@"status1"] = @"status";
    map[@"name2"] = @"name";
    map[@"status2"] = @"status";
}

- (void)setDataWithDic:(NSDictionary *)dic
{
    //    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    //        NSString *propertyKey = [self propertyForKey:key];
    //        if (propertyKey) {
    //            objc_property_t property = class_getProperty([self class],  [propertyKey UTF8String]);
    //            NSString *attributeString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    //            [self setValue:obj forKey:propertyKey];
    //        }
    //    }];
}

- (void)mysteriousMethod:(NSString *)string
{
    NSLog(@"RuntimeObjcTest mysteriousMethod == %@", string);
}

- (void)simulativeMultiInheritance:(NSString *)string
{
    NSLog(@"RuntimeObjcTest simulativeMultiInheritance == %@", string);
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
    {
        return YES;
    }
    else
    {
    }
    return NO;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    if ([super isKindOfClass:aClass])
    {
        return YES;
    }
    else
    {
    }
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    if ([super conformsToProtocol:aProtocol])
    {
        return YES;
    }
    else
    {
    }
    return NO;
}

+ (BOOL)instancesRespondToSelector:(SEL)aSelector
{
    if ([super instancesRespondToSelector:aSelector])
    {
        return YES;
    }
    else
    {
    }
    return NO;
}

@end
