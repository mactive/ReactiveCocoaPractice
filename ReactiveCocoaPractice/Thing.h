//
//  Thing.h
//  ReactiveCocoaPractice
//
//  Created by mengqian on 14/10/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ThingJSExport <JSExport>

@property(nonatomic, copy)NSString *name;
- (NSInteger)add:(NSInteger)a b:(NSInteger)b;


@end

@interface Thing : NSObject <ThingJSExport>
@property(nonatomic, copy)NSString *name;
@property(nonatomic) NSInteger *count;

- (NSInteger)add:(NSInteger)a b:(NSInteger)b;


@end
