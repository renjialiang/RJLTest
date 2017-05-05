//
//  RuntimeObjcTest.h
//  RJLTestPro
//
//  Created by admin on 17/3/16.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeObjcTest : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;

- (void)mysteriousMethod:(NSString *)string;
@end
