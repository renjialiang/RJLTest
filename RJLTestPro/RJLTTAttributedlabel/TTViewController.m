//
//  TTViewController.m
//  RJLTestPro
//
//  Created by mini on 16/7/21.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "TTViewController.h"

@implementation TTViewController
- (void)viewDidLoad
{
}

- (void)viewWillAppear:(BOOL)animated
{
	NSString * text = @"大成基金s";
	CGSize size = [self getHeightWithUseFont:self.label.font andWithContent:text andWithPadding:10 andWithUseRect:CGSizeMake(300, MAXFLOAT)];
	CGSize twosize = [self getHeightWithUseFont:self.labelTwo.font andWithContent:text andWithPadding:10 andWithUseRect:CGSizeMake(300, MAXFLOAT)];
	
	[self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, size.height + twosize.height + 300)];

	[self.label setFrame:CGRectMake(self.label.frame.origin.x, self.label.frame.origin.y, 300, size.height)];
	
	[self.labelTwo setFrame:CGRectMake(self.labelTwo.frame.origin.x, self.label.frame.origin.y +  self.label.frame.size.height + 100, 300, 20)];
	[self.labelTwo setLineSpacing:10];
	[self.labelTwo setText:text];
	[self.label setLineSpacing:10];
	[self.label setText:text];
	
}
- (CGSize)getHeightWithUseFont:(UIFont *)useFont andWithContent:(NSString *)text andWithPadding:(CGFloat)padding andWithUseRect:(CGSize)realSize
{
	CGRect textSize = [text boundingRectWithSize:CGSizeMake(realSize.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:useFont} context:nil];
	if (padding && padding > 0) {
		textSize.size.height += (textSize.size.height / useFont.lineHeight - 1) * padding;
	}
	return CGSizeMake(textSize.size.width, textSize.size.height);
}
@end
