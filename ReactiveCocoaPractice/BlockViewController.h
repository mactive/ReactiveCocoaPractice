//
//  BlockViewController.h
//  ReactiveCocoaPractice
//
//  Created by mengqian on 21/7/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^returnValueBlock)(NSString *input);
@interface BlockViewController : UIViewController

@property (nonatomic, strong) returnValueBlock returnValueBlock;

- (void)action:(returnValueBlock)block;
- (void)actionA;
@end

