//
//  NSObject+PreventSpil.m
//  RJLTestPro
//
//  Created by mini on 16/5/20.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "NSObject+PreventSpil.h"
#import <objc/runtime.h>
@implementation NSObject (PreventSpil)
+(void)load
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self swizzleSEL:@selector(forwardInvocation:) withSEL:@selector(swizzled_forwardInvocation:)];
//		[self swizzleSEL:@selector(respondsToSelector:) withSEL:@selector(swizzled_respondsToSelector:)];
//		[self swizzleSEL:@selector(resolveClassMethod:) withSEL:@selector(swizzled_resolveClassMethod:)];
//		[self swizzleSEL:@selector(forwardingTargetForSelector:) withSEL:@selector(swizzled_forwardingTargetForSelector:)];
//		[self swizzleSEL:@selector(methodSignatureForSelector:) withSEL:@selector(swizzled_methodSignatureForSelector:)];
	});
}

-(BOOL)swizzled_respondsToSelector:(SEL)aSelector
{
	return [self swizzled_respondsToSelector:aSelector];
}

- (NSMethodSignature*)swizzled_methodSignatureForSelector:(SEL)selector
{
	NSMethodSignature* methodSign = [self swizzled_methodSignatureForSelector:selector];
	if(methodSign == nil)
	{
		methodSign = [self methodSignatureForSelector:@selector(unusemethod)];
	}
	return methodSign;
}

- (id)unusemethod
{
	return nil;
}

- (id)swizzled_forwardingTargetForSelector:(SEL)aSelector
{
	return [self swizzled_forwardingTargetForSelector:aSelector];
}

- (void)swizzled_forwardInvocation:(NSInvocation*)invocation
{
//	if ([self respondsToSelector:@selector(unusemethod)])
//	{
//		[invocation setSelector:@selector(unusemethod)];
//		[invocation invokeWithTarget:self];
//	}
	NSString *str = NSStringFromSelector(invocation.selector);
	NSMethodSignature *methodSignature = [invocation methodSignature];

	NSInteger numberOfArguments = [methodSignature numberOfArguments];

	for (NSUInteger i = 2; i < numberOfArguments; i++)
	{
	 const char *argumentType = [methodSignature getArgumentTypeAtIndex:i];
	}
//	 switch(argumentType[0] == 'r' ? argumentType[1] : argumentType[0])
//		{
//			case '@': {
//				__unsafe_unretained id arg;
//				[invocation getArgument:&arg atIndex:i];
////				if ([arg isKindOfClass:NSClassFromString(@"NSBlock")]) {
////					[argList addObject:(arg ? [arg copy]: _nilObj)];
////				} else {
////					[argList addObject:(arg ? arg: _nilObj)];
////				}
//				break;
//			}
//			case '{': {
//				NSString *typeString = extractStructName([NSString stringWithUTF8String:argumentType]);
//#define JP_FWD_ARG_STRUCT(_type, _transFunc) \
//if ([typeString rangeOfString:@#_type].location != NSNotFound) {    \
//_type arg; \
//[invocation getArgument:&arg atIndex:i];    \
//[argList addObject:[JSValue _transFunc:arg inContext:_context]];  \
//break; \
//}
//				JP_FWD_ARG_STRUCT(CGRect, valueWithRect)
//				JP_FWD_ARG_STRUCT(CGPoint, valueWithPoint)
//				JP_FWD_ARG_STRUCT(CGSize, valueWithSize)
//				JP_FWD_ARG_STRUCT(NSRange, valueWithRange)
//				
//				@synchronized (_context) {
//					NSDictionary *structDefine = _registeredStruct[typeString];
//					if (structDefine) {
//						size_t size = sizeOfStructTypes(structDefine[@"types"]);
//						if (size) {
//							void *ret = malloc(size);
//							[invocation getArgument:ret atIndex:i];
//							NSDictionary *dict = getDictOfStruct(ret, structDefine);
//							[argList addObject:[JSValue valueWithObject:dict inContext:_context]];
//							free(ret);
//							break;
//						}
//					}
//				}
//				
//				break;
//			}
//			case ':': {
//				SEL selector;
//				[invocation getArgument:&selector atIndex:i];
//				NSString *selectorName = NSStringFromSelector(selector);
//				[argList addObject:(selectorName ? selectorName: _nilObj)];
//				break;
//			}
//			case '^':
//			case '*': {
//				void *arg;
//				[invocation getArgument:&arg atIndex:i];
//				[argList addObject:[JPBoxing boxPointer:arg]];
//				break;
//			}
//			case '#': {
//				Class arg;
//				[invocation getArgument:&arg atIndex:i];
//				[argList addObject:[JPBoxing boxClass:arg]];
//				break;
//			}
//			default: {
//				NSLog(@"error type %s", argumentType);
//				break;
//			}

	NSLog(@"%@",str);
//	ifmMessage* message = [self getMessageForSelector:NSStringFromSelector(anInvocation.selector)];
//	if (message) {
//
//		SEL selector = [message selectorForArgumentCount:argCount];
//		anInvocation.selector = selector;
//		anInvocation.target = message;
//
//		[anInvocation invoke];
//	}
}


+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL replaceClass:(Class)rClass
{
	Class class = rClass;
	
	Method originalMethod = class_getInstanceMethod(rClass, originalSEL);
//	Method swizzledMethod = class_getInstanceMethod(rClass, swizzledSEL);
	IMP swizzle = class_getMethodImplementation(rClass, swizzledSEL);
	class_replaceMethod(rClass,
						originalSEL,
						swizzle,
						method_getTypeEncoding(originalMethod));
//	OBJC_EXPORT IMP class_replaceMethod(Class cls, SEL name, IMP imp,
//										const char *types)
//	__OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

	
//	BOOL didAddMethod =
//	class_addMethod(rClass,
//					originalSEL,
//					method_getImplementation(swizzledMethod),
//					method_getTypeEncoding(swizzledMethod));
//	
//	if (didAddMethod) {
//		class_replaceMethod(rClass,
//							swizzledSEL,
//							method_getImplementation(originalMethod),
//							method_getTypeEncoding(originalMethod));
//	} else {
//		method_exchangeImplementations(originalMethod, swizzledMethod);
//	}
}


+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
	Class class = [self class];
	
	Method originalMethod = class_getInstanceMethod(class, originalSEL);
	Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
	
	BOOL didAddMethod =
	class_addMethod(class,
					originalSEL,
					method_getImplementation(swizzledMethod),
					method_getTypeEncoding(swizzledMethod));
	
	if (didAddMethod) {
		class_replaceMethod(class,
							swizzledSEL,
							method_getImplementation(originalMethod),
							method_getTypeEncoding(originalMethod));
	} else {
		method_exchangeImplementations(originalMethod, swizzledMethod);
	}
}
@end
