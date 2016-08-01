//
//  Person.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 22/7/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//
#import "Person.h"

@implementation Person
- (NSString *)getFullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

+ (instancetype) createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    Person *person = [[Person alloc] init];
    person.firstName = firstName;
    person.lastName = lastName;
    return person;
}
@end