//
//  GCDPracticeBarrier.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 26/8/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "GCDPracticeBarrier.h"
typedef void (^blk_t) (void);
typedef void (^blk_count) (int count);

@implementation GCDPracticeBarrier
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
    // Do any additional setup after loading the view.
    blk_t blk1_for_reading = ^(void){
        NSLog(@"blk 1 for reading");
    };
    
    blk_t blk2_for_reading = ^(void){
        NSLog(@"blk 2 for reading");
    };
    
    blk_t blk3_for_reading = ^(void){
        NSLog(@"blk 3 for reading");
    };
    
    blk_t blk3_for_writing = ^(void){
        NSLog(@"blk 3 for writing");
    };
    
    blk_t blk4_for_reading = ^(void){
        NSLog(@"blk 4 for reading");
    };
    blk_t blk5_for_reading = ^(void){
        NSLog(@"blk 5 for reading");
    };
    blk_t blk6_for_reading = ^(void){
        NSLog(@"blk 6 for reading");
    };
    
    dispatch_queue_t queue = dispatch_queue_create("com.thinktube.dispatch.barrier", DISPATCH_QUEUE_CONCURRENT);
    
    
    /**
     * 因为 dispatch_async 的第二个参数是 dispatch_block_t 类型的
     * typedef void (^dispatch_block_t)(void);
     * dispatch_block_t 的系统定义
     * 所以 blk_count 这种 定义出来的block是不能传入 dispatch_async的
     */
    blk_count blk_count_for_reading = ^(int count){
        NSLog(@"blk %d for reading",count);
    };
    
    dispatch_async(dispatch_get_main_queue(), ^{NSLog(@"Hello ?");});

    
    // this will crash
//    dispatch_async(queue, blk_count_for_reading(10));
    
    dispatch_async(queue, blk1_for_reading);
    dispatch_async(queue, blk2_for_reading);
    dispatch_async(queue, blk3_for_reading);
    dispatch_barrier_async(queue, blk3_for_writing);
    dispatch_async(queue, blk4_for_reading);
    dispatch_async(queue, blk5_for_reading);
    dispatch_async(queue, blk6_for_reading);
}




@end
