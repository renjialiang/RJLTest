//
//  RJLIndicatorStretchLabel.m
//  RJLTestPro
//
//  Created by mini on 16/5/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLIndicatorStretchLabel.h"
#import "RJLPublicTool.h"
@implementation RJLIndicatorStretchLabel
- (void)awakeFromNib
{
	[super awakeFromNib];
	self.numberOfLines = 0;
	if (self.defaultHeight == 0) {
		self.defaultHeight = self.bounds.size.height;
	}
}

- (void)setText:(NSString *)text
{
	[super setText:text];
	if (self.maxCol != 0)
	{
		CGSize actualSize = [RJLPublicTool boundingRectWithSize:self.bounds.size andText:text andTextFont:self.font];
		if (actualSize.height < self.defaultHeight * self.maxCol)
		{
			if (actualSize.height < self.defaultHeight) {
				if (self.frame.size.height > self.defaultHeight)
				{
					CGFloat dValue = self.frame.size.height - self.defaultHeight;
					[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.defaultHeight)];
					if (self.superview) {
						[self.superview setFrame:CGRectMake(self.superview.frame.origin.x, self.superview.frame.origin.y, self.superview.frame.size.width, self.superview.frame.size.height - dValue)];
					}
				}
			}
			else {
				[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, actualSize.height)];
				if (self.superview) {
					[self.superview setFrame:CGRectMake(self.superview.frame.origin.x, self.superview.frame.origin.y, self.superview.frame.size.width, self.superview.frame.size.height + actualSize.height - self.defaultHeight)];
				}
			}
		}
	}
}

- (void)setControlValue:(NSString *)value
{
	if (![value isKindOfClass:[NSString class]]) {
		return;
	}
	self.text = value;
}
@end
