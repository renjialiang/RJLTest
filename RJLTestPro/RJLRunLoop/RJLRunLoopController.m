//
//  RJLRunLoopController.m
//  RJLTestPro
//
//  Created by lichen on 2017/4/18.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import "RJLRunLoopController.h"
#import "RJLRuntimeTools.h"
#import "RJLRunLoopApplicationOne.h"
#import "RJLRunLoopApplicationTwo.h"

@interface RJLRunLoopController ()

@property (nonatomic, strong) UIButton *applicationOne;

@property (nonatomic, strong) UIButton *applicationTwo;

@end

static void MethodSwizzele(id self, SEL _cmd, id arg1){
    // do custom work
    MethodOriginal(self, _cmd, arg1);
}
@implementation RJLRunLoopController

+ (void)load
{
    [RJLRuntimeTools swizzleClass:[self class] selector:@selector(gotoDetailViewController:) with:(IMP)MethodSwizzele store:(IMP *)&MethodOriginal];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.applicationOne = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.applicationOne setTitle:@"RJLRunLoopApplicationOne" forState:UIControlStateNormal];
    [self.applicationOne setFrame:CGRectMake(100, 50, 200, 45)];
    [self.applicationOne addTarget:self action:@selector(gotoDetailViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_applicationOne];

    
    self.applicationTwo = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.applicationTwo setTitle:@"RJLRunLoopApplicationTwo" forState:UIControlStateNormal];
    [self.applicationTwo setFrame:CGRectMake(100, 100, 200, 45)];
    [self.applicationTwo addTarget:self action:@selector(gotoDetailViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_applicationTwo];
}


- (void)gotoDetailViewController:(UIButton *)sender
{
    NSString *btnText = [sender valueForKeyPath:@"titleLabel.text"];
    UIViewController *viewController = nil;
    if ([btnText isEqualToString:@"RJLRunLoopApplicationOne"])
    {
        viewController = [[RJLRunLoopApplicationOne alloc]initWithNibName:btnText bundle:[NSBundle mainBundle]];
    }
    else if ([btnText isEqualToString:@"RJLRunLoopApplicationTwo"])
    {
        viewController = [[RJLRunLoopApplicationTwo alloc]initWithNibName:btnText bundle:[NSBundle mainBundle]];
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
