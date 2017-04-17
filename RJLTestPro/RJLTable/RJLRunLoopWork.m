//
//  RJLRunLoopWork.m
//  RJLTestPro
//
//  Created by mini on 2017/2/22.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "RJLRunLoopWork.h"
#import <objc/runtime.h>

#define RJLRunLoopWork_DEBUG 1

@interface RJLRunLoopWork ()

@property (nonatomic, strong) NSMutableArray *tasks;

@property (nonatomic, strong) NSMutableArray *tasksKeys;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RJLRunLoopWork

- (void)removeAllTasks
{
	[self.tasks removeAllObjects];
	[self.tasksKeys removeAllObjects];
}


- (void)addTask:(RJLRunLoopWorkUnit)unit withKey:(id)key
{
	[self.tasks addObject:unit];
	[self.tasksKeys addObject:key];
	if (self.tasks.count > self.maximumQueueLength) {
		[self.tasks removeObjectAtIndex:0];
		[self.tasksKeys removeObjectAtIndex:0];
	}
}

- (void)_timerFiredMethod:(NSTimer *)timer {
	//We do nothing here
}


- (instancetype)init
{
	self = [super init];
	if (self) {
		_maximumQueueLength = 30;
		_tasks = [NSMutableArray array];
		_tasksKeys = [NSMutableArray array];
		_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(_timerFiredMethod:) userInfo:nil repeats:YES];
	}
	return self;
}

+ (instancetype)sharedRunLoopWork
{
	static RJLRunLoopWork *singleonce;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		singleonce = [[RJLRunLoopWork alloc]init];
		[self _registerRunLoopWorkAsMainRunloopObserver:singleonce];
	});
	return singleonce;
}

+ (void)_registerRunLoopWorkAsMainRunloopObserver:(RJLRunLoopWork *)runLoopWork
{
	static CFRunLoopObserverRef defaultModeObserver;
	_registerObserver(kCFRunLoopBeforeWaiting, defaultModeObserver, NSIntegerMax - 999, kCFRunLoopDefaultMode, (__bridge void *)runLoopWork, &_defaultModeRunLoopWorkDistributionCallback);
}


static void _registerObserver(CFOptionFlags activities, CFRunLoopObserverRef observer, CFIndex order, CFStringRef mode, void *info, CFRunLoopObserverCallBack callback)
{
	CFRunLoopRef runLoop = CFRunLoopGetCurrent();
	CFRunLoopObserverContext context = {
		0,
		info,
		&CFRetain,
		&CFRelease,
		NULL
	};
	observer = CFRunLoopObserverCreate(     NULL,
									   activities,
									   YES,
									   order,
									   callback,
									   &context);
	CFRunLoopAddObserver(runLoop, observer, mode);
	CFRelease(observer);
}
static void _runLoopWorkDistributionCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
	RJLRunLoopWork *runLoopWorkDistribution = (__bridge RJLRunLoopWork *)info;
	if (runLoopWorkDistribution.tasks.count == 0) {
		return;
	}
	BOOL result = NO;
	while (result == NO && runLoopWorkDistribution.tasks.count) {
		RJLRunLoopWorkUnit unit  = runLoopWorkDistribution.tasks.firstObject;
		result = unit();
		[runLoopWorkDistribution.tasks removeObjectAtIndex:0];
		[runLoopWorkDistribution.tasksKeys removeObjectAtIndex:0];
	}
}

static void _defaultModeRunLoopWorkDistributionCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
	_runLoopWorkDistributionCallback(observer, activity, info);
}
@end

@implementation UITableViewCell (RJLRunLoopWork)

@dynamic currentIndexPath;

- (NSIndexPath *)currentIndexPath {
	NSIndexPath *indexPath = objc_getAssociatedObject(self, @selector(currentIndexPath));
	return indexPath;
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath {
	objc_setAssociatedObject(self, @selector(currentIndexPath), currentIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

