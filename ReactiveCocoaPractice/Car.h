//
//  Car.h
//  ReactiveCocoaPractice
//
//  Created by mengqian on 19/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
{
    // 实例变量  因为下面用了了 @property
    // 所以这两行就没用了.
    NSString *carName;
    NSString *carType;
}

@property(nonatomic,strong) NSString *carName;
@property(nonatomic,strong) NSString *carType;

- (NSString *)carInfo;

@end
