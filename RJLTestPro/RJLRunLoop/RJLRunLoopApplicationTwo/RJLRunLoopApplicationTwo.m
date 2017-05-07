//
//  RJLRunLoopApplicationTwo.m
//  RJLTestPro
//
//  Created by lichen on 2017/4/20.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "RJLRunLoopApplicationTwo.h"
#import "RJLThread.h"

@interface RJLRunLoopApplicationTwo ()

@property (nonatomic, assign) RJLThread *subThread;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, assign) NSUInteger numCount;

@end

@implementation RJLRunLoopApplicationTwo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //同一线程里 需要同步Timer事件 到NSRunLoopCommonModes
    [self logOpenRunLoopWithThread];
    
    //多线程 独立RunLoop 相互不影响 CPU会在多个线程间切换来执行任务，呈现出多个线程同时执行的效果。
//    [self logThreadTest];
    
    [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 2000)];
    
}

- (void)logThreadTest
{
    NSLog(@"----------------logThreadTest--------------------");
    
    RJLThread *thread = [[RJLThread alloc]initWithTarget:self selector:@selector(logOpenRunLoopWithThread) object:nil];
    [thread start];
    self.subThread = thread;
    NSLog(@"-------------------------------------------------");
}

- (void)logOpenRunLoopWithThread
{
    NSLog(@"------------------logOpenRunLoopWithThread--------");
    @autoreleasepool
    {
//        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(logTimerUpdate) userInfo:nil repeats:YES];
//        [runLoop run];

        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(logTimerUpdate) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [timer fire];
        
    }
    NSLog(@"-------------------------------------------------");
}

- (void)logTimerUpdate
{
    NSLog(@"------------------logTimerUpdate-----------------");
    NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.numCount ++;
        NSString *timerText = [NSString stringWithFormat:@"计数器:%ld",self.numCount];
        self.timerLabel.text = timerText;
    });
    NSLog(@"-------------------------------------------------");
}

@end
