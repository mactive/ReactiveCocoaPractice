//
//  BlockViewController.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 21/7/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end


@implementation BlockViewController

@synthesize returnValueBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"xxx";
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)action:(returnValueBlock)block;
{
    block(@"ddddd");
}

- (void)actionA{
    self.returnValueBlock(@"xxxx");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
