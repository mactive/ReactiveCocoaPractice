//
//  ViewController.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 21/7/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "ViewController.h"
#import "BlockViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "PersonJSExports.h"
#import "GCDPracticeBarrier.h"
#import "GCDGroup.h"

@interface ViewController ()
@property(nonatomic,weak)NSNumber *num;
@end

typedef int (^blk_t)(int);
int global_val = 1;
static int static_global_val = 2;

@implementation ViewController
@synthesize num;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"账号绑定";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self testFuncC];
//    [self gcdTest3];
    [self blockTest1];
//    [self gcdTestTime];

//    [self blockPassValue];
    PersonJSExports *personJS = [[PersonJSExports alloc]init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    button.titleLabel.text = @"adfasdf";
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeInfoLight];
    button1.titleLabel.text = @"2222";
    [button1 setFrame:CGRectMake(100, 200, 100, 100)];
    [button1 addTarget:self action:@selector(action1) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeInfoLight];
    button2.titleLabel.text = @"3333";
    [button2 setFrame:CGRectMake(100, 300, 100, 100)];
    [button2 addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button2];


}

- (void)action{
    BlockViewController *blockVC = [[BlockViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:blockVC animated:YES];
}


- (void)action1{
    GCDPracticeBarrier *blockVC = [[GCDPracticeBarrier alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:blockVC animated:YES];
}

- (void)button2
{
    GCDGroup *blockVC = [[GCDGroup alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:blockVC animated:YES];
}


- (void)blockTest1
{
    int (^blk)(int) = ^(int count){return count+1;};
    int tmp = blk(10);
    NSLog(@"tmp %d",tmp);
    
    // 使用typedef的方式 定义一个名叫 blk2的block
    blk_t blk2 = ^(int count){return count+2;};
    int tmp2 = blk2(10);
    NSLog(@"tmp %d",tmp2);
    
    /**
     * 定义一个名叫blk3的 block
     * block中可以直接使用 全局变量和全局静态变量 无需加 __block
     * 其他的还是需要 __block
     */
    
    __block NSString *needChange = @"";
    void (^blk3)(void) = ^{
        global_val +=2;
        static_global_val +=1;
        needChange = @"had changed";
    };
    blk3();
}

-(void)gcdTestTime
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"3 secs later i run");
    });
}

-(void)gcdTest3
{
    dispatch_queue_t bridgeQueue = dispatch_queue_create("com.facebook.react.RCTBridgeQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t initModulesAndLoadSource = dispatch_group_create();
    // 进入
    dispatch_group_enter(initModulesAndLoadSource);
    
    // 1..n 丢入block执行
    dispatch_group_async(initModulesAndLoadSource, bridgeQueue, ^{
        NSLog(@"2");
    });
    
    dispatch_group_async(initModulesAndLoadSource, bridgeQueue, ^{
        NSLog(@"1");
    });
    
    dispatch_group_async(initModulesAndLoadSource, bridgeQueue, ^{
        sleep(2);
        NSLog(@"3");
    });
    
    dispatch_group_async(initModulesAndLoadSource, bridgeQueue, ^{
        sleep(2);
        NSLog(@"4");
    });
    
    dispatch_group_async(initModulesAndLoadSource, bridgeQueue, ^{
        sleep(2);
        NSLog(@"5");
    });
    
    //离开
    dispatch_group_leave(initModulesAndLoadSource);
    //group 都执行完毕后 notify
    dispatch_group_notify(initModulesAndLoadSource, bridgeQueue, ^{
        NSLog(@"finish");
    });

}

-(void)simplifyString
{
    JSContext *context = [[JSContext alloc] init];

    context[@"simplifyString"] = ^(NSString *input) {
        NSMutableString *mutableString = [input mutableCopy];
        // 任何语言转拉丁字符
        CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, NO);
        // 去掉重音和变音符,汉语就是拼音音调四声 平、上、去、入
        CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformStripCombiningMarks, NO);
        return mutableString;
    };
    
    NSLog(@"%@", [context evaluateScript:@"simplifyString('你好吗!')"]);
}

-(void)testFuncC
{
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:@"var num = 5 + 5"];
    [context evaluateScript:@"var names = ['Grace', 'Ada', 'Margaret']"];
    [context evaluateScript:@"var triple = function(value) { return value * 3 }"];
    JSValue *tripleNum = [context evaluateScript:[NSString stringWithFormat:@"triple(%@)",@"7"]];
     JSValue *tripleNum2 = [context evaluateScript:@"triple(num)"];
    
    NSLog(@"tripleNum: %ld",(long)[tripleNum toNumber].integerValue);
    JSValue *names = context[@"names"];
    JSValue *initialName = names[0];
    
    JSValue *tripleFunction = context[@"triple"];
    JSValue *result = [tripleFunction callWithArguments:@[@"5"]];
    NSLog(@"Five tripled: %d", [result toInt32]);
    
    context.exceptionHandler = ^(JSContext *context, JSValue *exception){
        NSLog(@"JS Error: %@",exception);
    };
    
    [context evaluateScript:@"function multiply(value1, value2){return value1 * value2"];
    // JS Error: SyntaxError: Unexpected end of script


}

-(void)gcdTest2
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSLog(@"1");
    });
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
        sleep(1);
        NSLog(@"2");
    });
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        sleep(1);
        NSLog(@"3");
    });
    
}

-(void)gcdTest1
{
    dispatch_queue_t concurrentDispatchQueue=dispatch_queue_create("com.test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"1");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        sleep(2);
        NSLog(@"2");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        sleep(1);
        NSLog(@"3");
    });
}

-(void)blockPassValue
{
    BlockViewController *vc = [[BlockViewController alloc]initWithNibName:nil bundle:nil];
    vc.returnValueBlock = ^(NSString *input) {
        NSLog(@"sss%@",input);
    };

    [vc actionA];

//    [vc action:^(NSString *input) {
//        NSLog(@"%@",input);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
