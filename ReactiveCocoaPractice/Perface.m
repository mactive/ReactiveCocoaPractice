//
//  Perface.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 20/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "Perface.h"

@implementation Perface

@synthesize delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Initialize self.
        // 需要给delegate对象指定宿主,要不无法去寻找具体的实现方法
        //self.delegate = self;
        
        if(delegate != nil && [delegate respondsToSelector:@selector(optionalSel)]){
            [delegate optionalSel];
        }
    }
    return self;
}

- (void)optionalSel
{
    NSLog(@"optionalSel");
}

- (void)requriedSel
{
    NSLog(@"requriedSel");
}

-(void)actionWithMethodName:(NSString*)methodName;
{
    // 默认方法
    if(delegate != nil && [delegate respondsToSelector:@selector(optionalSel)]){
        [delegate optionalSel];
    }
    //通过methodName 去反射方法
}

@end
