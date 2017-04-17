//
//  RJLTableControlView.m
//  RJLTestPro
//
//  Created by mini on 16/9/20.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLFPSLabel.h"
#import "RJLTableControlView.h"
#import "RJLTableView.h"
#import "UIView+RJLAdd.h"
#import "RJLRunLoopWork.h"
#import "RJLCrashHandler.h"
static NSString *IDENTIFIER = @"IDENTIFIER";

@interface RJLTableControlView () < UITableViewDataSource, UITableViewDelegate >
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RJLFPSLabel *fpsLabel;
@property (nonatomic, strong) UIButton *testBtn;
@end

@implementation RJLTableControlView


- (void)viewDidLoad
{
    [super viewDidLoad];

	_tableView = [[RJLTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	_tableView.delegate = self;
	_tableView.dataSource = self;
    _tableView.frame = self.view.bounds;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER];

	_testBtn = [UIButton buttonWithType:UIButtonTypeSystem];
	[_testBtn setFrame:CGRectMake(200, 0, 80, 50)];
	[_testBtn setBackgroundColor:[UIColor redColor]];
	[_testBtn addTarget:self action:@selector(handleLongPress:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_testBtn];

    _fpsLabel = [RJLFPSLabel new];
    [_fpsLabel sizeToFit];
	[_fpsLabel setBackgroundColor:[UIColor redColor]];
    _fpsLabel.top = 0;
    _fpsLabel.left = 10;
    _fpsLabel.alpha = 1;
    [self.view addSubview:_fpsLabel];
    if ([UIDevice currentDevice].systemVersion.doubleValue < 7)
    {
        _fpsLabel.top -= 44;
        _tableView.top -= 64;
        _tableView.height += 20;
    }

    // Do any additional setup after loading the view.
}
-(void)handleLongPress:(UIButton*)gestureRecognizer
{
	NSArray *array =[NSArray array];
	NSLog(@"%@",[array objectAtIndex:1]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (void)task_5:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	for (NSInteger i = 1; i <= 5; i++) {
		[[cell.contentView viewWithTag:i] removeFromSuperview];
	}
}

+ (void)task_1:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor redColor];
	label.text = [NSString stringWithFormat:@"%zd - Drawing index is top priority", indexPath.row];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.tag = 1;
	[cell.contentView addSubview:label];
}

+ (void)task_2:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath  {
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, 20, 85, 85)];
	imageView.tag = 2;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
	UIImage *image = [UIImage imageWithContentsOfFile:path];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.image = image;
	[UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
		[cell.contentView addSubview:imageView];
	} completion:^(BOOL finished) {
	}];
}

+ (void)task_3:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath  {
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 20, 85, 85)];
	imageView.tag = 3;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
	UIImage *image = [UIImage imageWithContentsOfFile:path];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.image = image;
	[UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
		[cell.contentView addSubview:imageView];
	} completion:^(BOOL finished) {
	}];
}

+ (void)task_4:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath  {
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 99, 300, 35)];
	label.lineBreakMode = NSLineBreakByWordWrapping;
	label.numberOfLines = 0;
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor colorWithRed:0 green:100.f/255.f blue:0 alpha:1];
	label.text = [NSString stringWithFormat:@"%zd - Drawing large image is low priority. Should be distributed into different run loop passes.", indexPath.row];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.tag = 4;
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 85, 85)];
	imageView.tag = 5;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
	UIImage *image = [UIImage imageWithContentsOfFile:path];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.image = image;
	[UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
		[cell.contentView addSubview:label];
		[cell.contentView addSubview:imageView];
	} completion:^(BOOL finished) {
	}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 399;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	static NSString *identifier = @"cellId";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	for (NSInteger i = 1; i <= 5; i++) {
		[[cell.contentView viewWithTag:i] removeFromSuperview];
	}
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor redColor];
	label.text = [NSString stringWithFormat:@"%zd - Drawing index is top priority", indexPath.row];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.tag = 1;
	[cell.contentView addSubview:label];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, 20, 85, 85)];
	imageView.tag = 2;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
	UIImage *image = [UIImage imageWithContentsOfFile:path];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
//	[imageView performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
	imageView.image = image;
	NSLog(@"current:%@",[NSRunLoop currentRunLoop].currentMode);
	[cell.contentView addSubview:imageView];
	
	UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 20, 85, 85)];
	imageView2.tag = 3;
	UIImage *image2 = [UIImage imageWithContentsOfFile:path];
	imageView2.contentMode = UIViewContentModeScaleAspectFit;
//	[imageView2 performSelector:@selector(setImage:) withObject:image2 afterDelay:0 inModes:@[NSDefaultRunLoopMode]];

	imageView2.image = image2;
	[cell.contentView addSubview:imageView2];
	
	UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 99, 300, 35)];
	label2.lineBreakMode = NSLineBreakByWordWrapping;
	label2.numberOfLines = 0;
	label2.backgroundColor = [UIColor clearColor];
	label2.textColor = [UIColor colorWithRed:0 green:100.f/255.f blue:0 alpha:1];
	label2.text = [NSString stringWithFormat:@"%zd - Drawing large image is low priority. Should be distributed into different run loop passes.", indexPath.row];
	label2.font = [UIFont boldSystemFontOfSize:13];
	label2.tag = 4;
	
	UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 85, 85)];
	imageView3.tag = 5;
	UIImage *image3 = [UIImage imageWithContentsOfFile:path];
	imageView3.contentMode = UIViewContentModeScaleAspectFit;
//	[imageView3 performSelector:@selector(setImage:) withObject:image3 afterDelay:0 inModes:@[NSDefaultRunLoopMode]];

	imageView3.image = image3;
	[cell.contentView addSubview:label2];
	[cell.contentView addSubview:imageView3];
	
	return cell;
	
	
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
//	cell.selectionStyle = UITableViewCellSelectionStyleNone;
//	cell.currentIndexPath = indexPath;
//	[RJLTableControlView task_5:cell indexPath:indexPath];
//	[RJLTableControlView task_1:cell indexPath:indexPath];
//	[[RJLRunLoopWork sharedRunLoopWork] addTask:^BOOL(void) {
//		if (![cell.currentIndexPath isEqual:indexPath]) {
//			return NO;
//		}
//		[RJLTableControlView task_2:cell indexPath:indexPath];
//		return YES;
//	} withKey:indexPath];
//	[[RJLRunLoopWork sharedRunLoopWork] addTask:^BOOL(void) {
//		if (![cell.currentIndexPath isEqual:indexPath]) {
//			return NO;
//		}
//		[RJLTableControlView task_3:cell indexPath:indexPath];
//		return YES;
//	} withKey:indexPath];
//	[[RJLRunLoopWork sharedRunLoopWork] addTask:^BOOL(void) {
//		if (![cell.currentIndexPath isEqual:indexPath]) {
//			return NO;
//		}
//		[RJLTableControlView task_4:cell indexPath:indexPath];
//		return YES;
//	} withKey:indexPath];
//	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 140;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

@end
