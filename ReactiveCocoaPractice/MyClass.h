//
//  ProtocolInherits.h
//  ReactiveCocoaPractice
//
//  Created by mengqian on 21/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//
@protocol A
@property (nonatomic, readonly) NSString* name;

@required
-(void) methodA;

@end

// B 协议继承自 A,协议也可以多重继承, 比如 <A, NSObject>
@protocol B <A>
@required
-(void) methodB;
@end

// ===================================
@interface MyClass : NSObject <B>
// 协议可以被实例实现, 也可以赋值给变量使用
@property(nonatomic, weak) id <B> delegate;
@end

@implementation MyClass
@synthesize delegate;
@synthesize name; // A的name属性也是可以直接用

-(instancetype)init
{
    self = [super init];
    if(self){
        [delegate methodB]; // 可以调用B的方法
        [delegate methodA]; // 可以调用B继承的A的方法
        // 这里这两个方法不会执行, 因为delegate的宿主并不是这个类. 除非self.delegate = self;
        // 那么会走下面的两个方法 methodB methodA. delegate指向谁,谁负责实现
    }
    return self;
}
-(void)methodB  // 必须要实现
{
}
-(NSString *)name{
    return @"MyClass";
}
-(void)methodA // 必须要实现
{
    NSLog(@"methodA: %@",self.name);
}
@end

