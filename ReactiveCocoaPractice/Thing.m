//
//  Thing.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 14/10/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "Thing.h"

@implementation Thing

- (NSInteger)add:(NSInteger)a b:(NSInteger)b
{
    NSLog(@"Native Log: %ld %ld",a,b);
    return a + b;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@: %ld",self.name, self.count];
}
@end
