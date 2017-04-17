//
//  ifmChartLeftScaleComponent.m
//  RJLTestPro
//
//  Created by mini on 2016/10/9.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartLeftScaleComponent.h"
@implementation ifmChartLeftScaleComponent
- (void)draw:(UIView *)superView chartContext:(CGContextRef)context chartRect:(CGRect)rect chartData:(ifmChartData *)data
{
    if (data.lineData == nil || data.curveData == nil || data.curveData.count == 0)
    {
        return;
    }
    if (self.scaleColor == nil)
    {
        self.scaleColor = [UIColor grayColor];
    }
    if (self.scaleFont == nil)
    {
        self.scaleFont = [UIFont systemFontOfSize:10];
    }
    NSInteger count = [self getScaleCount:data];
    if (count == 0)
    {
        return;
    }
    BOOL failScale = NO;
    if ([data getValueMax] - [data getValueMin] == 0)
    {
        failScale = YES;
    }
    CGRect rectScale = rect;
    CGFloat maxScale = [data getValueMax];
    CGFloat minScale = [data getValueMin];
    CGFloat valueRow = (maxScale - minScale) / (count - 1);
    CGFloat rcRow = rectScale.size.height / (count - 1);
    CGRect rectRow = rectScale;
    rectRow.size.height = self.scaleFont.lineHeight;
    for (int i = 0; i < count; i++)
    {
        CGFloat value = maxScale - valueRow * i;
        if (failScale)
        {
            value = maxScale;
        }
        rectRow.origin.y = rectScale.origin.y - self.scaleFont.lineHeight / 2 + rcRow * i;
        if (i == 0)
        {
            rectRow.origin.y += self.scaleFont.lineHeight / 2;
        }
        else if (i == count - 1)
        {
            rectRow.origin.y -= self.scaleFont.lineHeight / 2;
        }
        NSString *strleft = [iFMCurveDrawTool ChangeValueFormat:value decimalBit:data.decimal carryBit:NO];
        [iFMCurveDrawTool drawText:context text:strleft textRect:rectRow textColor:_scaleColor.CGColor textFont:_scaleFont alignMent:_textAlignment];
    }
}

- (NSInteger)getScaleCount:(ifmChartData *)data
{
    if (self.countType == ScaleCountUpAndDwon)
    {
        return 2;
    }
    else if (self.countType == ScaleCountUpMidDwon)
    {
        return 3;
    }
    else
    {
        return data.borderHorCount;
    }
}
@end
