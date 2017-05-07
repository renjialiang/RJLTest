//
//  RJLRunLoopController.h
//  RJLTestPro
//
//  Created by lichen on 2017/4/18.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

// RunLoop 模型 Event Loop 作用：管理事件/消息,如何让线程在没有处理消息时休眠以避免
//资源占用、在有消息到来时立刻被唤醒
//NSRunLoop 和 CFRunLoopRef(线程安全)
//RunLoop 中保存的是RunLoopMode，而RunLoopMode中保存的才是实际的任务
//struct __CFRunLoopMode {
//    CFStringRef _name;            // Mode Name, 例如 @"kCFRunLoopDefaultMode"
//    CFMutableSetRef _sources0;    // Set
//    CFMutableSetRef _sources1;    // Set
//    CFMutableArrayRef _observers; // Array
//    CFMutableArrayRef _timers;    // Array
//    ...
//};
//
//struct __CFRunLoop {
//    CFMutableSetRef _commonModes;     // Set
//    CFMutableSetRef _commonModeItems; //Set<Source/Observer/Timer>
//    CFRunLoopModeRef _currentMode;    // Current Runloop Mode
//    CFMutableSetRef _modes;           // Set
//    ...
//};

//CFRunLoop对外暴露的管理 Mode 接口只有下面2个:
//CFRunLoopAddCommonMode(CFRunLoopRef runloop, CFStringRef modeName);
//CFRunLoopRunInMode(CFStringRef modeName, ...);


/// 用DefaultMode启动
//void CFRunLoopRun(void) {
//    CFRunLoopRunSpecific(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, 1.0e10, false);
//}
//
///// 用指定的Mode启动，允许设置RunLoop超时时间
//int CFRunLoopRunInMode(CFStringRef modeName, CFTimeInterval seconds, Boolean stopAfterHandle) {
//    return CFRunLoopRunSpecific(CFRunLoopGetCurrent(), modeName, seconds, returnAfterSourceHandled);
//}
//
///// RunLoop的实现
//int CFRunLoopRunSpecific(runloop, modeName, seconds, stopAfterHandle) {
//    
//    /// 首先根据modeName找到对应mode
//    CFRunLoopModeRef currentMode = __CFRunLoopFindMode(runloop, modeName, false);
//    /// 如果mode里没有source/timer/observer, 直接返回。
//    if (__CFRunLoopModeIsEmpty(currentMode)) return;
//    
//    /// 1. 通知 Observers: RunLoop 即将进入 loop。
//    __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopEntry);
//    
//    /// 内部函数，进入loop
//    __CFRunLoopRun(runloop, currentMode, seconds, returnAfterSourceHandled) {
//        
//        Boolean sourceHandledThisLoop = NO;
//        int retVal = 0;
//        do {
//            
//            /// 2. 通知 Observers: RunLoop 即将触发 Timer 回调。
//            __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopBeforeTimers);
//            /// 3. 通知 Observers: RunLoop 即将触发 Source0 (非port) 回调。
//            __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopBeforeSources);
//            /// 执行被加入的block
//            __CFRunLoopDoBlocks(runloop, currentMode);
//            
//            /// 4. RunLoop 触发 Source0 (非port) 回调。
//            sourceHandledThisLoop = __CFRunLoopDoSources0(runloop, currentMode, stopAfterHandle);
//            /// 执行被加入的block
//            __CFRunLoopDoBlocks(runloop, currentMode);
//            
//            /// 5. 如果有 Source1 (基于port) 处于 ready 状态，直接处理这个 Source1 然后跳转去处理消息。
//            if (__Source0DidDispatchPortLastTime) {
//                Boolean hasMsg = __CFRunLoopServiceMachPort(dispatchPort, &msg)
//                if (hasMsg) goto handle_msg;
//            }
//            
//            /// 通知 Observers: RunLoop 的线程即将进入休眠(sleep)。
//            if (!sourceHandledThisLoop) {
//                __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopBeforeWaiting);
//            }
//            
//            /// 7. 调用 mach_msg 等待接受 mach_port 的消息。线程将进入休眠, 直到被下面某一个事件唤醒。
//            /// • 一个基于 port 的Source 的事件。
//            /// • 一个 Timer 到时间了
//            /// • RunLoop 自身的超时时间到了
//            /// • 被其他什么调用者手动唤醒
//            __CFRunLoopServiceMachPort(waitSet, &msg, sizeof(msg_buffer), &livePort) {
//                mach_msg(msg, MACH_RCV_MSG, port); // thread wait for receive msg
//            }
//            
//            /// 8. 通知 Observers: RunLoop 的线程刚刚被唤醒了。
//            __CFRunLoopDoObservers(runloop, currentMode, kCFRunLoopAfterWaiting);
//            
//            /// 收到消息，处理消息。
//        handle_msg:
//            
//            /// 9.1 如果一个 Timer 到时间了，触发这个Timer的回调。
//            if (msg_is_timer) {
//                __CFRunLoopDoTimers(runloop, currentMode, mach_absolute_time())
//            }
//            
//            /// 9.2 如果有dispatch到main_queue的block，执行block。
//            else if (msg_is_dispatch) {
//                __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__(msg);
//            }
//            
//            /// 9.3 如果一个 Source1 (基于port) 发出事件了，处理这个事件
//            else {
//                CFRunLoopSourceRef source1 = __CFRunLoopModeFindSourceForMachPort(runloop, currentMode, livePort);
//                sourceHandledThisLoop = __CFRunLoopDoSource1(runloop, currentMode, source1, msg);
//                if (sourceHandledThisLoop) {
//                    mach_msg(reply, MACH_SEND_MSG, reply);
//                }
//            }
//            
//            /// 执行加入到Loop的block
//            __CFRunLoopDoBlocks(runloop, currentMode);
//            
//            
//            if (sourceHandledThisLoop && stopAfterHandle) {
//                /// 进入loop时参数说处理完事件就返回。
//                retVal = kCFRunLoopRunHandledSource;
//            } else if (timeout) {
//                /// 超出传入参数标记的超时时间了
//                retVal = kCFRunLoopRunTimedOut;
//            } else if (__CFRunLoopIsStopped(runloop)) {
//                /// 被外部调用者强制停止了
//                retVal = kCFRunLoopRunStopped;
//            } else if (__CFRunLoopModeIsEmpty(runloop, currentMode)) {
//                /// source/timer/observer一个都没有了
//                retVal = kCFRunLoopRunFinished;
//            }
//            
//            /// 如果没超时，mode里没空，loop也没被停止，那继续loop。
//        } while (retVal == 0);
//    }
//    
//    /// 10. 通知 Observers: RunLoop 即将退出。
//    __CFRunLoopDoObservers(rl, currentMode, kCFRunLoopExit);
//}

#import <UIKit/UIKit.h>

@interface RJLRunLoopController : UIViewController

@end
