//
//  PersonJSExports.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 23/7/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "PersonJSExports.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Person.h"
#import "Thing.h"
#import <UIKit/UIKit.h>

@interface PersonJSExports()
@property(nonatomic, strong)JSContext * context;

@end

@implementation PersonJSExports
@synthesize context;

-(id)init
{
    if ((self = [super init])){
        // set self
//        [self initContext];
        [self instanceContext];
        [self thinsContext];
    }
    return self;
}

- (void)thinsContext
{
    self.context = [[JSContext alloc] init];
    
    // 拦截console.log 方法
    [self.context evaluateScript:@"var console = {}"];
    self.context[@"console"][@"log"] = ^(NSString *message) {
        NSLog(@"Javascript log: %@",message);
    };

    Thing *thing = [[Thing alloc]init];
    thing.name = @"Alfred";
    thing.count = 27;
    
    context[@"thing"] = thing;
    JSValue *thingValue = context[@"thing"];
    [self.context evaluateScript:@"var result = thing.addB(10,3); console.log(thing.addB)"];

    JSValue *result = self.context[@"result"];

    NSLog(@"----%@",[result toString]);
    

    

}

-(void)instanceContext{
    self.context = [[JSContext alloc] init];
    
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"JS Error: %@", exception);
    };
    
    JSValue *u = [JSValue valueWithSize:CGSizeMake(300, 200) inContext:self.context];
    NSLog(@"toSize: %f", u.toSize.width);
    
    
    NSString *js = @"function add(a,b) {return a+b}";
    [self.context evaluateScript:js];
    JSValue *n = [self.context[@"add"] callWithArguments:@[@2,@3]];
    NSLog(@"----%@",@([n toInt32]));
    
    JSValue *func = self.context[@"add"];
    JSValue *m = [func callWithArguments:@[@2,@3]];

    
    // 注入
    self.context[@"multi"] = ^(NSInteger a, NSInteger b){
        NSInteger c = a * b;
        NSLog(@"--%ld", (long)c);
        return c;
    };
    
    
//    self.context[@"nativeRender"] = ^(NSDictionary *ViewModel){
//        ViewModel *viewModel = [ViewModel trans:ViewModel];
//        UIView *view = [[UIView alloc]initWithViewModel:viewModel];
//        [weakSelf render];
//    };

    [self.context evaluateScript:@"multi(2,3)"];
    
    NSString *j2s = @"function plus(a,b) {return multi(a,b)*10 }";
    [self.context evaluateScript:j2s];

    JSValue *q = [self.context[@"plus"] callWithArguments:@[@2,@3]];
    NSLog(@"q %@",@([q toInt32]));


    // another block
    context[@"simplifyString"] = ^(NSString *input) {
        NSMutableString *mutableString = [input mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformStripCombiningMarks, NO);
        return mutableString;
    };
    
    NSLog(@"%@", [context evaluateScript:@"simplifyString('안녕하새요!')"]);
    NSLog(@"%@", [context evaluateScript:@"simplifyString('你好世界!')"]);
    
    

}

-(void)initContext
{
    context = [[JSContext alloc] init];
//    [context evaluateScript:@"var num = 5 + 5"];
//    [context evaluateScript:@"var names = ['Grace', 'Ada', 'Margaret']"];
//    [context evaluateScript:@"var triple = function(value) { return value * 3 }"];
//
    JSValue *tripleNum2 = [context evaluateScript:@"triple(num)"];
//    NSLog(@"tripleNum2: %d",[tripleNum2 toInt32]);
    
    // 给JS提供Object 和方法 其实就是model  Person.createWithFirstName:lastName:;
    context[@"Person"] = [Person class];

    // load PeopleJson
    // 加载测试数据
    NSString *peopleJSON = [NSString stringWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource: @"people" ofType: @"json"]
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];

    // load People.js
    // 加载people解析js文件, 这个js文件中使用了 Person.createWithFirstNameLastName方法
    NSString *peopleJSString = [NSString stringWithContentsOfFile:
                                [[NSBundle mainBundle] pathForResource: @"people" ofType: @"js"]
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil];
    [context evaluateScript:peopleJSString];
    JSValue *load = context[@"loadPeopleFromJSON"];
    
    // call with JSON and convert to an NSArray
    JSValue *loadResult = [load callWithArguments:@[peopleJSON]];
    // 得到一个包含三个Person class 的数\
    
    NSArray *people = [loadResult toArray];



}


@end
