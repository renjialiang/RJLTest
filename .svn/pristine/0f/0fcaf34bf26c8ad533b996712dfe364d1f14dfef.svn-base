//
//  RJLIndicatorView.m
//  RJLTestPro
//
//  Created by mini on 16/5/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLIndicatorView.h"
#import "RJLIndicatorLabel.h"
#import "RJLIndicatorStretchLabel.h"

@interface RJLIndicatorView ()
@property (nonatomic, readwrite, strong) NSMutableDictionary	*dicControls;
@property (nonatomic, readwrite, strong) NSMutableArray			*dataIds;
@end
@implementation RJLIndicatorView
#pragma mark -Initialize Method
- (void)dealloc
{
	
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self initControl];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initControl];
	}
	return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self initControl];
}

- (void)initControl
{
	self.dicControls = [[NSMutableDictionary alloc] init];
	self.dataIds = [[NSMutableArray alloc] init];
	for (UIView *view in self.subviews)
	{
		if ([view isKindOfClass:[RJLIndicatorLabel class]] && ((RJLIndicatorLabel *)view).dataId)
		{
			[_dicControls setObject:view forKey:((RJLIndicatorLabel *)view).dataId];
			[_dataIds addObject:((RJLIndicatorLabel *)view).dataId];
		}
		else if ([view isKindOfClass:[RJLIndicatorStretchLabel class]] && ((RJLIndicatorStretchLabel *)view).dataId)
		{
			[_dicControls setObject:view forKey:((RJLIndicatorStretchLabel *)view).dataId];
			[_dataIds addObject:((RJLIndicatorStretchLabel *)view).dataId];
		}
		
	}
}
#pragma mark - Public Method
- (void)setControlValue:(id)value dataId:(NSString *)dataId
{
	UIView* control = [self findControlById:dataId];
	if ([control isKindOfClass:[RJLIndicatorLabel class]]) {
		[((RJLIndicatorLabel *)control) setControlValue:value];
	}
	else if ([control isKindOfClass:[RJLIndicatorStretchLabel class]]) {
		[((RJLIndicatorStretchLabel *)control) setControlValue:value];
	}
}

- (UIView *)findControlById:(NSString*)dataId
{
	if (_dicControls)
	{
		return [_dicControls objectForKey:dataId];
	}
	return nil;
}
@end
