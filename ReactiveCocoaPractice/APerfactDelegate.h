//
//  APerfactDelegate.h
//  ReactiveCocoaPractice
//
//  Created by mengqian on 20/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#ifndef APerfactDelegate_h
#define APerfactDelegate_h

@protocol APerfectDelegate <NSObject>

@property(nonatomic, readonly)NSString *name;
@property(nonatomic, readonly)NSNumber *count;

@optional
- (void)optionalSel;

@required
- (void)requriedSel;

@end


#endif /* APerfactDelegate_h */
