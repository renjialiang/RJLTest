//
//  UIViewController+Tracking.m
//  RJLTestPro
//
//  Created by admin on 17/4/18.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class aClass = [self class];
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(xxx_viewDidAppear:);
        
        Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)xxx_viewDidAppear:(BOOL)animated
{
    [self xxx_viewDidAppear:animated];
    NSLog(@"viewDidAppear: %@",self);
}

@end
