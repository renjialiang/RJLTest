//
//  RJLCrashHandler.h
//  RJLTestPro
//
//  Created by mini on 2017/2/28.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJLCrashHandler : NSObject
{
	BOOL ignore;
}

+ (instancetype)sharedInstance;
@end
