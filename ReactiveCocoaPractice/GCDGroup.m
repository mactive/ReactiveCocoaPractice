//
//  GCDGroup.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 29/8/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "GCDGroup.h"

@implementation GCDGroup
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"xxx";
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self dispatchGroupNotifyDemo];
//    [self dispatchGroupWaitDemo];
    [self groupSync2];
}

- (void)dispatchGroupNotifyDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
    // dispatch_group_notify 不会 block住之后的代码
    // NSLog 在 main thread 可以先执行

    NSLog(@"can continue");
}

//dispatch_group_wait
- (void)dispatchGroupWaitDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    //在group中添加队列的block
    dispatch_group_async(group, concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    // dispatch_group_wait 会 block住之后的代码
    // NSLog 绝对不会再 main thread 先执行

    NSLog(@"can continue");
}

- (void)groupSync2
{
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        sleep(2);
        NSLog(@"任务一完成");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        sleep(2);
        NSLog(@"任务二完成");
    });
    dispatch_group_async(dispatchGroup, globalQueue, ^{
        sleep(3);
        NSLog(@"任务三完成");
    });
    // dispatch_group_notify 不管你是在哪个queue上执行的 都会等你执行完在做事
    // 上面的例子 我们在两个 queue 上执行
    // 一个 串行的 dispatchQueue 一个系统默认的并行的globalQueue
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"notify：任务都完成了");
    });
}


@end
