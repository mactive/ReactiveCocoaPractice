//
//  Perface.h
//  ReactiveCocoaPractice
//
//  Created by mengqian on 20/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APerfactDelegate.h"
@interface Perface : NSObject<APerfectDelegate>

@property(nonatomic, assign) id<APerfectDelegate> delegate;

-(void)actionWithMethodName:(NSString*)methodName;


@end
