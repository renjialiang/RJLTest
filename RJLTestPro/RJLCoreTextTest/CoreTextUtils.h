//
//  CoreTextUtils.h
//  RJLTestPro
//
//  Created by mini on 16/6/16.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"
#import "CoreTextData.h"
@interface CoreTextUtils : NSObject
+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;

+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;
@end
