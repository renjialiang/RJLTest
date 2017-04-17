//
//  CoreTextData.h
//  RJLTestPro
//
//  Created by mini on 16/6/14.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreImageData.h"
@interface CoreTextData : NSObject

@property (assign, nonatomic) CTFrameRef ctFrame;
@property (assign, nonatomic) CGFloat height;
@property (nonatomic, copy) NSArray	*imageArray;
@property (nonatomic, copy) NSArray *linkArray;
@property (nonatomic, copy) NSAttributedString	*content;
@end
