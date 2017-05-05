//
//  RJLRuntimeTools.m
//  RJLTestPro
//
//  Created by admin on 17/4/18.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "RJLRuntimeTools.h"

@implementation RJLRuntimeTools
+ (void)MethodSwizzle:(Class)aClass andOrigSel:(SEL)orig_sel andSwizzleSel:(SEL)swizzle_sel
{
    Method orig_method = class_getInstanceMethod(aClass, orig_sel);
    Method swizzled_method = class_getInstanceMethod(aClass, swizzle_sel);

    BOOL didAddMethod = class_addMethod(aClass, orig_sel, method_getImplementation(swizzled_method), method_getTypeEncoding(swizzled_method));
    if (didAddMethod)
    {
        class_replaceMethod(aClass, swizzle_sel, method_getImplementation(orig_method), method_getTypeEncoding(orig_method));
    }
    else
    {
        method_exchangeImplementations(orig_method, swizzled_method);
    }
}

+ (BOOL)changeFromClass:(nonnull id)objClass variableName:(nonnull NSString *)ivarName changeVariable:(nonnull id)changeIvar
{
    Ivar ivar = class_getInstanceVariable([objClass class], [ivarName UTF8String]);
    if (ivar)
    {
        object_setIvar(objClass, ivar, changeIvar);
        return YES;
    }
    return NO;
}

+ (nullable id)getIvarFromObject:(nonnull id)objc variableName:(nonnull NSString *)ivarName
{
    Ivar ivar = class_getInstanceVariable([objc class], [ivarName UTF8String]);
    if (ivar)
    {
        return object_getIvar(objc, ivar);
    }
    return nil;
}

+ (NSString *)nameFromObject:(id)objc withInstance:(id)instance
{
    unsigned int numIvars = 0;
    NSString *key = nil;
    Ivar *ivars = class_copyIvarList([objc class], &numIvars);
    for (int i = 0; i < numIvars; i++)
    {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        if (![stringType hasPrefix:@"@"])
        {
            continue;
        }
        if (object_getIvar(objc, thisIvar) == instance)
        {
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }
    }
    free(ivars);
    return key;
}

@end
