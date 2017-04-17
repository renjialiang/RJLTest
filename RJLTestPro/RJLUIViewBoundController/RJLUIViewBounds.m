//
//  RJLUIViewBounds.m
//  RJLTestPro
//
//  Created by mini on 16/4/7.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLUIViewBounds.h"
@interface RJLUIViewBounds ()

@property (nonatomic, strong) UIView	*view1;
@property (nonatomic, strong) UIView	*view2;

@end

@implementation RJLUIViewBounds
- (void)viewDidLoad
{
	_view1 = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
//	[_view1 setBounds:CGRectMake(25, 25, 200, 200)];
	[_view1 setBackgroundColor:[UIColor greenColor]];
	[self.view addSubview:_view1];
	
//	_view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//	[_view2 setBounds:CGRectMake(50, 50, 100, 100)];
//	[_view2 setBackgroundColor:[UIColor redColor]];
//	[_view1 addSubview:_view2];
	
	NSLog(@"view1 frame:%@\nview1 bounds:%@\nview1 center:%@",NSStringFromCGRect(_view1.frame),NSStringFromCGRect(_view1.bounds),NSStringFromCGPoint(_view1.center));
//	NSLog(@"view2 frame:%@\nview2 bounds:%@\nview2 center:%@",NSStringFromCGRect(_view2.frame),NSStringFromCGRect(_view2.bounds),NSStringFromCGPoint(_view2.center));
}

- (void)viewDidAppear:(BOOL)animated
{
	CGPoint centerPoint1 = CGPointMake(_view1.center.x, _view1.center.y);
	[_view1 setBounds:CGRectMake(50, 100, 200, 300)];
//	[_view1 setCenter:centerPoint1];
	NSLog(@"view1 frame:%@\nview1 bounds:%@\nview1 center:%@",NSStringFromCGRect(_view1.frame),NSStringFromCGRect(_view1.bounds),NSStringFromCGPoint(_view1.center));
}
@end
