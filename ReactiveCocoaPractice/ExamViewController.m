//
//  ExamViewController.m
//  ReactiveCocoaPractice
//
//  Created by mengqian on 18/9/2016.
//  Copyright © 2016 thinktube. All rights reserved.
//

#import "ExamViewController.h"
#import "Perfact.h"
#import "MyClass.h"

@interface ExamViewController ()<APerfectDelegate>
@end

@implementation ExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    Perfact *per = [[Perfact alloc] init];
    per.delegate = self;
    [per actionWithMethodName:nil];
    
    MyClass *cls = [[MyClass alloc]init];
    NSLog(@"MyClass's name: %@",cls.name);
    [cls methodA];
}

-(void)optionalSel
{
    NSLog(@"ExamViewController optionalSel");
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
