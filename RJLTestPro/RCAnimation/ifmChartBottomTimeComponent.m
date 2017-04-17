//
//  ifmChartBottomTimeComponent.m
//  RJLTestPro
//
//  Created by mini on 2016/10/13.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartBottomTimeComponent.h"

@implementation ifmChartBottomTimeComponent
- (void)draw:(UIView *)superView chartContext:(CGContextRef)context chartRect:(CGRect)rect chartData:(ifmChartData *)data
{
    if (data.lineData == nil || data.curveData == nil || data.curveData.count == 0)
    {
        return;
    }
    if (self.timeColor == nil)
    {
        self.timeColor = [UIColor grayColor];
    }
    if (self.timeFont == nil)
    {
        self.timeFont = [UIFont systemFontOfSize:10];
    }
    NSInteger count = [self getTimeCount:data];
    if (count == 0)
    {
        return;
    }
    NSArray *timeScales;
    if ([data getChartType] == ChartAssessmentType)
    {
        timeScales = @[ @"09:30", @"11:30", @"15:00" ];
    }
    else
    {
    }

    CGFloat cellwidth = rect.size.width / (count - 1);
    for (int i = 0; i < count; i++)
    {
        if (i < count)
        {
            CGRect cellrect = CGRectMake(rect.origin.x + cellwidth * i, rect.origin.y, cellwidth, rect.size.height);
            CGSize fontSize = [iFMCurveDrawTool calTextSize:_timeFont text:[timeScales objectAtIndex:i]];
            cellrect.size.width = fontSize.width;
            if (i > 0)
            {
                cellrect.origin.x -= (fontSize.width / 2);
            }
            if (i == count - 1)
            {
                cellrect.origin.x -= (fontSize.width / 2);
            }
            [iFMCurveDrawTool drawText:context text:[timeScales objectAtIndex:i] textRect:cellrect textColor:_timeColor.CGColor textFont:_timeFont alignMent:NSTextAlignmentCenter];
        }
    }
}

- (NSInteger)getTimeCount:(ifmChartData *)data
{
    if (self.countType == TimeCountLeftAndRight)
    {
        return 2;
    }
    else if (self.countType == TimeCountLeftMidRight)
    {
        return 3;
    }
    else
    {
        return data.borderVerCount;
    }
}
@end
