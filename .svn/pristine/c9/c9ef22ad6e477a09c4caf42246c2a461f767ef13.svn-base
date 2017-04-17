//
//  RJLFactoryClass.m
//  RJLTestPro
//
//  Created by mini on 16/4/20.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLFactoryClass.h"
#import "RJLConcreateFactoryOne.h"
#import "RJLConcreateFactoryTwo.h"
@implementation RJLFactoryClass
+ (id<RJLAbstractProtocol>)create:(OutPutTypes)type
{
	switch (type) {
		case TimeStamp:
			return [[RJLConcreateFactoryOne alloc]init];
			break;
		case NoTimeStamp:
			return [[RJLConcreateFactoryTwo alloc]init];
			break;
		default:
			break;
	}
}
@end
