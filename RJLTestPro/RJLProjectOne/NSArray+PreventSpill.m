//
//  NSArray+PreventSpill.m
//  RJLTestPro
//
//  Created by mini on 16/5/20.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "NSArray+PreventSpill.h"
#import "NSObject+PreventSpil.h"

//@interface NSArray<__covariant ObjectType> ()
//@end

@implementation NSArray(PreventSpill)
//+ (void)load
//{
//	static dispatch_once_t onceToken;
//	dispatch_once(&onceToken, ^{
//		[self swizzleSEL:@selector(objectAtIndex:) withSEL:@selector(swizzled_objectAtIndex:)];
//	});
//}

//-(NSArray<__covariant ObjectType *> *)swizzled_objectAtIndex:(NSUInteger)index
//{
//	return [self objectAtIndex:index];
//}

//- (id)swizzled_objectAtIndex:(NSUInteger)index {
//	if (index >= self.count) {
//		return nil;
//	}
//	return [self objectAtIndex:index];
//}
@end
