//
//  RJLRunLoopWork.h
//  RJLTestPro
//
//  Created by mini on 2017/2/22.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^RJLRunLoopWorkUnit)(void);

@interface RJLRunLoopWork : NSObject

@property (nonatomic, assign) NSUInteger maximumQueueLength;

+ (instancetype)sharedRunLoopWork;

- (void)addTask:(RJLRunLoopWorkUnit)unit withKey:(id)key;

- (void)removeAllTasks;

@end

@interface UITableViewCell (RJLRunLoopWork)

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end
