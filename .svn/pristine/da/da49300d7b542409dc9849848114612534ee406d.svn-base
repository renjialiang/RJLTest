//
//  ifmChartDynamicIndexComponent.m
//  RJLTestPro
//
//  Created by mini on 2016/10/12.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartDynamicIndexComponent.h"

@implementation ifmChartDynamicIndexComponent
- (void)draw:(UIView *)superView chartContext:(CGContextRef)context chartRect:(CGRect)rect chartData:(ifmChartData *)data
{
    if (data.needCross)
    {
        //绘制十字与浮动框
        CGRect rectRight;
        if (CGRectContainsPoint(data.curveRect, data.currentPoint))
        {
            rectRight = data.curveRect;
        }
        else
        {
            return;
        }

        if (data.pointCount < 0 || (!CGRectContainsPoint(data.curveRect, data.currentPoint)))
        {
            return;
        }

        //十字
        CGColorRef color = [UIColor blackColor].CGColor;

        CGPoint pointLeft = CGPointMake(data.curveRect.origin.x, data.currentPoint.y);
        [iFMCurveDrawTool drawPixelHorizontal:context pointBegin:pointLeft lineLength:data.curveRect.size.width lineWidth:1 color:color];

        CGPoint pointTop = CGPointMake(data.currentPoint.x, data.curveRect.origin.y);
        [iFMCurveDrawTool drawPixelVertical:context pointBegin:pointTop lineLength:data.curveRect.size.height lineWidth:1 color:color];
    }
}
@end
