//
//  Person.h
//  ReactiveCocoaPractice
//
//  Created by mengqian on 22/7/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@class Person;

@protocol PersonJSExports <JSExport>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property NSInteger ageToday;

- (NSString *)getFullName;

// create and return a new Person instance with `firstName` and `lastName`
+ (instancetype)createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;
@end


@interface Person : NSObject <PersonJSExports>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property NSInteger ageToday;
@end
