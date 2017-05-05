//
//  RunTimeObjectOne+Category.m
//  RJLTestPro
//
//  Created by admin on 17/4/17.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "RunTimeObjectOne+Category.h"
#import <objc/runtime.h>

@implementation RunTimeObjectOne (Category)

+ (void)load
{
    SEL originalSelector = @selector(ReceiveMessage:);
    SEL overrideSelector = @selector(replacementReceiveMessage:);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method overrideMethod = class_getInstanceMethod(self, overrideSelector);
    
    if (class_addMethod(self, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(self, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else{
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

- (void)ReceiveMessage:(NSString *)str
{
    NSLog(@"ReceiveMessage---%@",str);
}

- (void)replacementReceiveMessage:(NSString *)str
{
    [self replacementReceiveMessage:str];
    NSLog(@"replacementReceiveMessage---%@",str);
}

@end
