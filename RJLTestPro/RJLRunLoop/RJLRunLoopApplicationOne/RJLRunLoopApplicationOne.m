//
//  RJLRunLoopApplicationOne.m
//  RJLTestPro
//
//  Created by lichen on 2017/4/19.
//  Copyright © 2017年 renjialiang. All rights reserved.
//


#import "RJLRunLoopApplicationOne.h"
#import "RJLThread.h"
@interface RJLRunLoopApplicationOne ()
@property (nonatomic, weak) RJLThread *rjlThread;
@property (assign, nonatomic) CFRunLoopTimerRef cfTimer;
@end

@implementation RJLRunLoopApplicationOne

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self logThreadTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{

}

- (void)logStopRunLoop
{
    //CF的数据源可以采用CFRunLoopStop停止当前RunLoop
//    if (_cfTimer) {
//        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
//        CFRunLoopStop(currentRunLoop);
//        CFRunLoopRemoveTimer(currentRunLoop, _cfTimer, kCFRunLoopCommonModes);
//        CFRelease(_cfTimer);
//        _cfTimer = NULL;
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   [self performSelector:@selector(logStopRunLoop) onThread:self.rjlThread withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
}

- (void)logThreadTest
{
    NSLog(@"----------------logThreadTest--------------------");

    RJLThread *thread = [[RJLThread alloc]initWithTarget:self selector:@selector(logOpenRunLoopWithThread) object:nil];
    [thread start];
    self.rjlThread = thread;
    NSLog(@"-------------------------------------------------");

}

- (void)logOpenRunLoopWithThread
{
    NSLog(@"------------------logOpenRunLoopWithThread--------");
    @autoreleasepool
    {

//        CFRunLoopRef cfRunLoop = CFRunLoopGetCurrent();
//        CFRunLoopTimerContext context = {0, (__bridge void*)self, NULL, NULL, NULL};
//        _cfTimer = CFRunLoopTimerCreate(kCFAllocatorDefault, 0.1, 1, 0, 0,
//                                                        &runLoopTimerCallBack, &context);
//        CFRunLoopAddTimer(cfRunLoop, _cfTimer, kCFRunLoopCommonModes);
//        CFRunLoopRun();
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
//        [runLoop run];//线程永驻
        [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    }
    NSLog(@"-------------------------------------------------");
}

- (void)logThreadOpetion
{
    NSLog(@"------------------logThreadOpetion---------------");
    @autoreleasepool {
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"%@",CFRunLoopGetCurrent());
    }
    NSLog(@"-------------------------------------------------");
}

static void runLoopTimerCallBack(CFRunLoopTimerRef timer, void *info)
{
    NSLog(@"------------------runLoopTimerCallBack---------------");
    NSLog(@"-----------------------------------------------------");
}

@end
