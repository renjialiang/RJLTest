//
//  ifmChartLineComponent.m
//  RJLTestPro
//
//  Created by mini on 2016/10/9.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartLineComponent.h"

@implementation ifmChartLineComponent
- (void)draw:(UIView *)superView chartContext:(CGContextRef)context chartRect:(CGRect)rect chartData:(ifmChartData *)data
{
    if (data.columnCount == 0)
    {
        return;
    }
    CGPoint *points = (CGPoint *)(malloc(sizeof(CGPoint) * data.columnCount));
    NSArray *pointArray = [[data.curveData objectAtIndex:0] objectForKey:CURVEPOINT];
    for (NSInteger index = 0; index < data.columnCount; index++)
    {
        points[index] = [[pointArray objectAtIndex:index] CGPointValue];
    }
    [iFMCurveDrawTool drawCurve:context pointArray:points arrayCount:data.columnCount lineColor:[UIColor blueColor].CGColor lineWidth:1];
}
@end
