//
//  ifmChartBorderComponent.m
//  RJLTestPro
//
//  Created by mini on 2016/10/9.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartBorderComponent.h"

@implementation ifmChartBorderComponent
- (void)draw:(UIView *)superView chartContext:(CGContextRef)context chartRect:(CGRect)rect chartData:(ifmChartData *)data
{
    if (self.isDashedLine)
    {
        [iFMCurveDrawTool drawDashedLineHorizontal:context pointBegin:CGPointMake(rect.origin.x, rect.origin.y) lineLength:rect.size.width color:self.frameColor.CGColor];
        [iFMCurveDrawTool drawDashedLineHorizontal:context pointBegin:CGPointMake(rect.origin.x, rect.size.height + rect.origin.y - 1) lineLength:rect.size.width color:self.frameColor.CGColor];
        [iFMCurveDrawTool drawDashedLineVertical:context pointBegin:CGPointMake(rect.origin.x, rect.origin.y) lineLength:rect.size.height color:self.frameColor.CGColor];
        [iFMCurveDrawTool drawDashedLineVertical:context pointBegin:CGPointMake(rect.origin.x + rect.size.width - 1, rect.origin.y) lineLength:rect.size.height color:self.frameColor.CGColor];
        if (data.borderHorCount > 0)
        {
            for (NSUInteger i = 1; i <= data.borderHorCount; i++)
            {
                [iFMCurveDrawTool drawDashedLineHorizontal:context pointBegin:CGPointMake(rect.origin.x, rect.origin.y + (rect.size.height / (data.borderHorCount + 1) * i)) lineLength:rect.size.width color:self.frameColor.CGColor];
            }
        }
        if (data.borderVerCount > 0)
        {
            for (NSUInteger i = 1; i <= data.borderVerCount; i++)
            {
                [iFMCurveDrawTool drawDashedLineVertical:context pointBegin:CGPointMake(rect.origin.x + (rect.size.width / (data.borderVerCount + 1) * i), rect.origin.y) lineLength:rect.size.height color:self.frameColor.CGColor];
            }
        }
    }
    else
    {
        [iFMCurveDrawTool drawPixelHorizontal:context pointBegin:CGPointMake(rect.origin.x, rect.origin.y) lineLength:rect.size.width lineWidth:1 color:self.frameColor.CGColor];
        [iFMCurveDrawTool drawPixelHorizontal:context pointBegin:CGPointMake(rect.origin.x, rect.size.height + rect.origin.y - 1) lineLength:rect.size.width lineWidth:1 color:self.frameColor.CGColor];
        [iFMCurveDrawTool drawPixelVertical:context pointBegin:CGPointMake(rect.origin.x, rect.origin.y) lineLength:rect.size.height lineWidth:1 color:self.frameColor.CGColor];
        [iFMCurveDrawTool drawPixelVertical:context pointBegin:CGPointMake(rect.origin.x + rect.size.width - 1, rect.origin.y) lineLength:rect.size.height lineWidth:1 color:self.frameColor.CGColor];
        if (data.borderHorCount > 0)
        {
            for (NSUInteger i = 1; i <= data.borderHorCount; i++)
            {
                [iFMCurveDrawTool drawPixelHorizontal:context pointBegin:CGPointMake(rect.origin.x, rect.origin.y + (rect.size.height / (data.borderHorCount + 1) * i)) lineLength:rect.size.width lineWidth:1 color:self.frameColor.CGColor];
            }
        }
        if (data.borderVerCount > 0)
        {
            for (NSUInteger i = 1; i <= data.borderVerCount; i++)
            {
                [iFMCurveDrawTool drawPixelVertical:context pointBegin:CGPointMake(rect.origin.x + (rect.size.width / (data.borderVerCount + 1) * i), rect.origin.y) lineLength:rect.size.height lineWidth:1 color:self.frameColor.CGColor];
            }
        }
    }
}
@end
