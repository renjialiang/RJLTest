//
//  ifmChartTopLegendComponent.m
//  RJLTestPro
//
//  Created by mini on 2016/10/13.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartTopLegendComponent.h"

@implementation ifmChartTopLegendComponent
- (void)draw:(UIView *)superView chartContext:(CGContextRef)context chartRect:(CGRect)rect chartData:(ifmChartData *)data
{
    if (self.legendColor == nil)
    {
        self.legendColor = [UIColor grayColor];
    }
    if (self.legendFont == nil)
    {
        self.legendFont = [UIFont systemFontOfSize:14];
    }
    if ([data getChartType] == ChartAssessmentType)
    {
        [iFMCurveDrawTool drawText:context text:@"估算收益仅供参考，实际涨幅以最新净值为准 " textRect:rect textColor:_legendColor.CGColor textFont:_legendFont alignMent:NSTextAlignmentLeft];
    }
    else
    {
    }
}
@end
