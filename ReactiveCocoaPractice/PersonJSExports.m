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

@interface PersonJSExports()
@property(nonatomic, strong)JSContext * context;

@end

@implementation PersonJSExports
@synthesize context;

-(id)init
{
    if ((self = [super init])){
        // set self
        [self initContext];
    }
    return self;
}
-(void)initContext
{
    context = [[JSContext alloc] init];
//    [context evaluateScript:@"var num = 5 + 5"];
//    [context evaluateScript:@"var names = ['Grace', 'Ada', 'Margaret']"];
//    [context evaluateScript:@"var triple = function(value) { return value * 3 }"];
//
//    JSValue *tripleNum2 = [context evaluateScript:@"triple(num)"];
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
