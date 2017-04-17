//
//  NSObject+PreventSpil.h
//  RJLTestPro
//
//  Created by mini on 16/5/20.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PreventSpil)
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL replaceClass:(Class)rClass;
@end
