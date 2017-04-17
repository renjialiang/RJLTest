//
//  RJLProjectVC.m
//  RJLTestPro
//
//  Created by mini on 16/5/17.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLProjectVC.h"
#import "NSObject+PreventSpil.h"
#import <objc/message.h>
@interface RJLProjectVC ()

@end

@implementation RJLProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
//	NSMutableArray *sdf = [[NSMutableArray alloc]initWithArray:@[@"adsf", @"asdfsda"]];
//	[sdf removeLastObject];
//	self.adSrollView = [[RJLAdvertisementSrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200) timeInterval:10.0 subViewArray:@[@"appIntroduction_1.jpg", @"appIntroduction_2.jpg", @"appIntroduction_3.jpg"] dataArray:nil exParam:@{InputSubViewType:@3, SelfAutoLayoutWithImage:@NO}];
//	[self.view addSubview:_adSrollView];
//	self.automaticallyAdjustsScrollViewInsets = NO;
//	_adSrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//	
//	UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 300, 30, 30)];
////	[btn setBackgroundColor:[UIColor redColor]];
////	[btn addTarget:self action:@selector(asdfa:) forControlEvents:UIControlEventTouchUpInside];
////	[self.view addSubview:btn];
//	
//	NSArray* ar = @[@"asdfasdf",@"asdfsdf"];
//	CGFloat rect= ((UIButton*)ar).frame.size.height;
//	
//	NSString *asdf = [ar objectAtIndex:0];
//	NSString *adsfasdf = [ar objectAtIndex:1];
//	[(NSMutableArray *)btn addObject:@"asdf"];
    // Do any additional setup after loading the view.
//	objc_msgSend(self,@selector(sadf));
	
//	NSMutableSet *ads = [[NSMutableSet alloc]initWithArray:@[@"1",@"2",@"3",@"1",@"1"]];
//	[ads addObject:@"2"];
//	BOOL flag = [ads containsObject:@"1"];
//	NSLog(@"%@",flag?@"YES":@"NO");
//	+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;

	[NSObject swizzleSEL:@selector(run) withSEL:@selector(runOther) replaceClass:[self class]];
	[self run];
}
- (void)run
{
	NSLog(@"adsfasdf");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
//	[self.indicView setControlValue:@"adsf" dataId:@"a"];
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
