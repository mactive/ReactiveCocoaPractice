//
//  ProtocolInherits.h
//  ReactiveCocoaPractice
//
//  Created by mengqian on 21/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#ifndef ProtocolInherits_h
#define ProtocolInherits_h



@protocol A
-(void) methodA;
@end

// B 协议继承自 A,
// 协议也可以多重继承, 比如 <A, NSObject>
@protocol B <A>
-(void) methodB;
@end

@interface instance : NSObject <B>

// 协议可以被实例实现, 也可以赋值给变量使用
@property(nonatomic, weak) id <B> delegate;

@end

@implementation instance
@synthesize delegate;
-(instancetype)init
{
    self = [super init];
    if(self){
        [delegate methodB]; // 可以调用B的方法
        [delegate methodA]; // 可以调用B继承的A的方法
    }
    return self;
}

-(void)methodB
{
    // 必须要实现
}

-(void)methodA
{
    // 必须要实现
}

@end


#endif /* ProtocolInherits_h */
