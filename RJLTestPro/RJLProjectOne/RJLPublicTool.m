//
//  RJLPublicTool.m
//  RJLTestPro
//
//  Created by mini on 16/5/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLPublicTool.h"
#define DefaultFontSize 15
@implementation RJLPublicTool
+ (CGSize)boundingRectWithSize:(CGSize)size andText:(NSString *)text andTextFont:(UIFont*)font
{
	if (font == nil) {
		font = [UIFont systemFontOfSize:DefaultFontSize];
	}
	NSDictionary *attribute = @{NSFontAttributeName : font};
	CGSize retSize = [text boundingRectWithSize:CGSizeMake(size.width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
	return retSize;
}

+ (CGSize)getHeightWithUseFont:(UIFont *)useFont andWithContent:(NSString *)text andWithPadding:(CGFloat)padding andWithUseRect:(CGSize)realSize
{
	CGRect textSize = [text boundingRectWithSize:CGSizeMake(realSize.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:useFont} context:nil];
	if (padding && padding > 0) {
		textSize.size.height += (textSize.size.height / useFont.lineHeight - 1) * padding;
	}
	return CGSizeMake(textSize.size.width, textSize.size.height);
}
@end
