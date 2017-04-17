//
//  NSObject+WeakObserver.m
//  RJLTestPro
//
//  Created by mini on 16/5/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "NSObject+WeakObserver.h"
#import "NSObject+PreventSpil.h"
static const void *weakTarget = &weakTarget;

@implementation WeakObserverInfo
- (void)dealloc
{

}
@end
@implementation NSObject (WeakObserver)
//+ (void)load {
//	static dispatch_once_t onceToken;
//	dispatch_once(&onceToken, ^{
//		[self swizzleSEL:@selector(addObserver:selector:name:object:) withSEL:@selector(addWeaKObserver:selector:name:object:)];
//	});
//}

- (void)addWeaKObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject
{
	WeakObserverInfo *info = [WeakObserverInfo new];
	info.observer = observer;
	info.action = aSelector;
	info.namePath = aName;
	info.object = anObject;
//	objc_setAssociatedObject(self, weakTarget, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

//	[self addWeaKObserver:<#(id)#> selector:<#(SEL)#> name:<#(nullable NSString *)#> object:<#(nullable id)#>]
}

//-(void)addWeaKObserver:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
//{
//	WeakTargetInfo* info = [WeakTargetInfo new];
//	info.target = target;
//	info.action = action;
//	objc_setAssociatedObject(self, weakTarget, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//	
//	[self addWeakTarget:self action:@selector(origAction:) forControlEvents:controlEvents];
//}
//
//-(void)origAction:(id)sender
//{
//	WeakTargetInfo* info = objc_getAssociatedObject(self, weakTarget);
//	if (info.target)
//	{
//		[info.target performSelectorOnMainThread:info.action withObject:sender waitUntilDone:NO];
//	}
//}

@end
