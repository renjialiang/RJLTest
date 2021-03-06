//
//  MagnifiterView.m
//  RJLTestPro
//
//  Created by mini on 16/6/14.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "MagnifiterView.h"

@implementation MagnifiterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:CGRectMake(0, 0, 80, 80)]) {
		// make the circle-shape outline with a nice border.
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 1;
		self.layer.cornerRadius = 40;
		self.layer.masksToBounds = YES;
	}
	return self;
}

- (void)setTouchPoint:(CGPoint)touchPoint {
	_touchPoint = touchPoint;
	// update the position of the magnifier (to just above what's being magnified)
	self.center = CGPointMake(touchPoint.x, touchPoint.y - 70);
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	// here we're just doing some transforms on the view we're magnifying,
	// and rendering that view directly into this view,
	// rather than the previous method of copying an image.
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, self.width * 0.5, self.height * 0.5);
	CGContextScaleCTM(context, 1.5, 1.5);
	CGContextTranslateCTM(context, -1 * (_touchPoint.x), -1 * (_touchPoint.y));
	[self.viewToMagnify.layer renderInContext:context];
}
@end
