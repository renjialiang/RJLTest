//
//  RJLFluencyMonitor.h
//  RJLTestPro
//
//  Created by mini on 2017/2/28.
//  Copyright © 2017年 renjialiang. All rights reserved.
//
//{
//	/// 1. 通知Observers，即将进入RunLoop
//	/// 此处有Observer会创建AutoreleasePool: _objc_autoreleasePoolPush();
//	__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopEntry);
//	do {
//		
//		/// 2. 通知 Observers: 即将触发 Timer 回调。
//		__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeTimers);
//		/// 3. 通知 Observers: 即将触发 Source (非基于port的,Source0) 回调。
//		__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeSources);
//		__CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__(block);
//		
//		/// 4. 触发 Source0 (非基于port的) 回调。
//		__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__(source0);
//		__CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__(block);
//		
//		/// 6. 通知Observers，即将进入休眠
//		/// 此处有Observer释放并新建AutoreleasePool: _objc_autoreleasePoolPop(); _objc_autoreleasePoolPush();
//		__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeWaiting);
//		
//		/// 7. sleep to wait msg.
//		mach_msg() -> mach_msg_trap();
//		
//		
//		/// 8. 通知Observers，线程被唤醒
//		__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopAfterWaiting);
//		
//		/// 9. 如果是被Timer唤醒的，回调Timer
//		__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__(timer);
//		
//		/// 9. 如果是被dispatch唤醒的，执行所有调用 dispatch_async 等方法放入main queue 的 block
//		__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__(dispatched_block);
//		
//		/// 9. 如果如果Runloop是被 Source1 (基于port的) 的事件唤醒了，处理这个事件
//		__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE1_PERFORM_FUNCTION__(source1);
//		
//		
//	} while (...);
//	
//	/// 10. 通知Observers，即将退出RunLoop
//	/// 此处有Observer释放AutoreleasePool: _objc_autoreleasePoolPop();
//	__CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopExit);
//}
#import <Foundation/Foundation.h>

@interface RJLFluencyMonitor : NSObject
+ (instancetype)shareMonitor;

- (void)startWithInterval:(NSTimeInterval)interval fault:(NSTimeInterval)fault;

- (void)start;

- (void)stop;

@end
