//
//  Car.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 19/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "Car.h"

@implementation Car

@synthesize carName = _carName;
@synthesize carType = _carType;

- (NSString *)carInfo
{
    return [NSString stringWithFormat:
            @"The car name is %@ and the type is %@",
            _carName,  // _carName 不是self的一部分,应该是临时变量
            self.carType];
}

@end
