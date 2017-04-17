//
//  ifmChart.m
//  RJLTestPro
//
//  Created by mini on 2016/10/9.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChart.h"
#include <sys/time.h>
@interface ifmChart ()

@end

@implementation ifmChart

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame chartData:(ifmChartData *)data
{
    self = [self initWithFrame:frame];
    if (self)
    {
        rcChartFrame = CGRectZero;
        rcTopScale = CGRectZero;
        rcLeftScale = CGRectZero;
        rcRightScale = CGRectZero;
        rcBottomScale = CGRectZero;
        self.chartData = data;
        [self initMyFrame];
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}

- (void)refreshCurrentChart
{
    [self setNeedsDisplay];
}

- (void)setChartComponent:(ifmChartComponent *)component
{
    if (self.components == nil)
    {
        self.components = [[NSMutableArray alloc] initWithCapacity:10];
    }
    [_components addObject:component];
}

- (void)initMyFrame
{
    if (!self.chartData)
    {
        return;
    }
    rcChartFrame = CGRectMake(_chartData.paddingLeft, _chartData.paddingTop, self.frame.size.width - _chartData.paddingLeft - _chartData.paddingRight, self.frame.size.height - _chartData.paddingTop - _chartData.paddingBottom);
    rcTopScale = CGRectMake(self.frame.origin.x + rcChartFrame.origin.x, 0, rcChartFrame.size.width, rcChartFrame.origin.y);
    rcLeftScale = CGRectMake(self.frame.origin.x, rcChartFrame.origin.y, fabs(rcChartFrame.origin.x - self.frame.origin.x), rcChartFrame.size.height);
    rcRightScale = CGRectMake(rcChartFrame.size.width + rcChartFrame.origin.x, rcChartFrame.origin.y, fabs(self.frame.size.width - rcChartFrame.size.width - rcChartFrame.origin.x), rcChartFrame.size.height);
    rcBottomScale = CGRectMake(rcChartFrame.origin.x, rcChartFrame.origin.y + rcChartFrame.size.height, rcChartFrame.size.width, fabs(self.frame.size.height - rcChartFrame.origin.y - rcChartFrame.size.height));
    self.chartData.curveRect = rcChartFrame;
}

- (void)setChartCurveData:(NSDictionary *)dicData
{
    if (!self.chartData)
    {
        return;
    }
    [_chartData setLineData:dicData];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (!self.chartData)
    {
        return;
    }
    for (ifmChartComponent *comp in self.components)
    {
        if (comp.drawType == draw_in_top)
        {
            [comp draw:self chartContext:context chartRect:rcTopScale chartData:self.chartData];
        }
        if (comp.drawType == draw_in_left)
        {
            [comp draw:self chartContext:context chartRect:rcLeftScale chartData:self.chartData];
        }
        if (comp.drawType == draw_in_right)
        {
            [comp draw:self chartContext:context chartRect:rcRightScale chartData:self.chartData];
        }
        if (comp.drawType == draw_in_bottom)
        {
            [comp draw:self chartContext:context chartRect:rcBottomScale chartData:self.chartData];
        }
        if (comp.drawType == draw_in_graph)
        {
            [comp draw:self chartContext:context chartRect:rcChartFrame chartData:self.chartData];
        }
    }
}

#pragma mark - GestureHandle_Method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchCount += [touches count];

    if (_chartData.pointCount <= 0)
    {
        return;
    }

    if (_touchCount >= 2)
    {
        _touchAction = TouchAction_DoubleMove;
    }
    if ([touches count] >= 2)
    {
        CGPoint pointFirst = [[[touches allObjects] objectAtIndex:0] locationInView:self];
        CGPoint pointSecond = [[[touches allObjects] objectAtIndex:1] locationInView:self];
        _touchSize.width = fabs(pointFirst.x - pointSecond.x);
        _touchSize.height = fabs(pointFirst.y - pointSecond.y);
        return;
    }
    if (_touchCount == 2)
    {
        CGPoint point = [[[touches allObjects] objectAtIndex:0] locationInView:self];
        _touchSize.width = fabs(point.x - _touchSize.width);
        _touchSize.height = fabs(point.y - _touchSize.height);
        return;
    }
    else if (_touchCount == 1)
    {
        CGPoint point = [[[touches allObjects] objectAtIndex:0] locationInView:self];
        _touchSize.width = fabs(point.x);
        _touchSize.height = fabs(point.y);
        if (CGRectContainsPoint(rcChartFrame, point))
        {
            _chartData.needCross = YES;
            [self setCursorPoint:point];
        }
    }
    CGPoint pt = [[touches anyObject] locationInView:self];
    _touchPoint = pt;
    _moveAction = MoveAction_None;
    [self SetStartTime];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_chartData.pointCount <= 0)
    {
        return;
    }
    if ([touches count] == 2)
    {
        CGPoint pointFirst = [[[touches allObjects] objectAtIndex:0] locationInView:self];
        CGPoint pointSecond = [[[touches allObjects] objectAtIndex:1] locationInView:self];
        int width = fabs(pointFirst.x - pointSecond.x);
        int height = fabs(pointFirst.y - pointSecond.y);
        int dx = width - _touchSize.width;
        int dy = height - _touchSize.height;
        if (dx > ZOOM_MOVE_WIDTH_VERTICAL || dy > ZOOM_MOVE_WIDTH_VERTICAL)
        {
            _touchSize.width = fabs(pointFirst.x - pointSecond.x);
            _touchSize.height = fabs(pointFirst.y - pointSecond.y);

            int centerX = (pointFirst.x + pointSecond.x) / 2;
            [self zoomCurve:NO centerX:centerX];
        }
        else if (dx < -ZOOM_MOVE_WIDTH_VERTICAL || dy < -ZOOM_MOVE_WIDTH_VERTICAL)
        {
            _touchSize.width = fabs(pointFirst.x - pointSecond.x);
            _touchSize.height = fabs(pointFirst.y - pointSecond.y);

            int centerX = (pointFirst.x + pointSecond.x) / 2;
            [self zoomCurve:YES centerX:centerX];
        }
        return;
    }
    CGPoint pt = [[touches anyObject] locationInView:self];
    if (_touchAction == TouchAction_None)
    {
        if (_moveAction == MoveAction_None)
        {
            int dx = fabs(pt.x - _touchPoint.x);
            if ([self GetLastTime] < 200 && dx < 100) //0.2s 100像素
            {
                return;
            }
            else
            {
                if (dx > 10) //快速移动为滑动
                {
                    if (_moveSwitch)
                    {
                        _moveAction = MoveAction_Curve;
                    }
                    else
                    {
                        _moveAction = MoveAction_Cursor;
                    }
                }
                else //缓慢移动为查看
                {
                    _moveAction = MoveAction_Cursor;
                }
                _touchAction = TouchAction_Move;
            }
        }
    }

    if (_touchAction == TouchAction_Move)
    {
        if (_moveAction == MoveAction_Curve)
        {
            _chartData.needCross = NO;
            int dx = pt.x - _touchPoint.x;
            if (dx < 0)
            {
                int moveColumn = dx / _chartData.columnWidth;
                if (_chartData.columnStart + _chartData.columnCount - moveColumn <= _chartData.pointCount)
                {
                    _chartData.columnStart = _chartData.columnStart - moveColumn;
                    _touchPoint.x = _touchPoint.x + moveColumn * _chartData.columnWidth;
                }
                else
                {
                    _chartData.columnStart = _chartData.pointCount - _chartData.columnCount;
                    _touchPoint.x = pt.x;
                }
                [_chartData calculateCurveData];
                [self setNeedsDisplay];
                return;
            }
            else if (dx > 0)
            {
                int moveColumn = dx / _chartData.columnWidth;
                if (_chartData.columnStart - moveColumn >= 0)
                {
                    _chartData.columnStart = _chartData.columnStart - moveColumn;
                    _touchPoint.x = _touchPoint.x + moveColumn * _chartData.columnWidth;
                }
                else
                {
                    _chartData.columnStart = 0;
                }
                [_chartData calculateCurveData];
                [self setNeedsDisplay];
                return;
            }
        }
        else if (_moveAction == MoveAction_Cursor)
        {
            [self setCursorPoint:pt];
            _touchPoint = pt;
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //双指变单指重置位置
    if (_touchCount == 2 && [touches count] == 1)
    {
        CGPoint point = [[[touches allObjects] objectAtIndex:0] locationInView:self];
        _touchSize.width = fabs(point.x);
        _touchSize.height = fabs(point.y);
    }
    _touchCount -= [touches count];
    if (_touchCount < 0)
    {
        _touchCount = 0;
    }
    if (_chartData.pointCount <= 0)
    {
        return;
    }
    if (_touchAction != TouchAction_None) //单击操作要不触发其他操作才可以实现
    {
        if (_touchCount == 0)
        {
            _touchAction = TouchAction_None;
            _moveAction = MoveAction_None;
        }
        [self performSelector:@selector(hideCross) withObject:nil afterDelay:0.1];
        return;
    }
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self setCursorPoint:pt];

    if (_moveAction == MoveAction_Curve)
    {
        return;
    }
    if (CGRectContainsPoint(rcChartFrame, pt))
    {
        [self performSelector:@selector(hideCross) withObject:nil afterDelay:0.1];
    }
}

- (void)SetStartTime
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    _startTime = tv.tv_sec % 86400 * 1000 + tv.tv_usec / 1000; //(60*60*24) = 86400
}

- (NSInteger)GetLastTime
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    int sec = tv.tv_sec % 86400 * 1000 + tv.tv_usec / 1000; //(60*60*24) = 86400
    return sec - _startTime;
}

- (void)hideCross //去掉十字
{
    @autoreleasepool
    {
        _chartData.needCross = NO;
        [self setCursorPoint:CGPointMake(rcChartFrame.origin.x + _chartData.columnWidth * _chartData.columnCount, rcChartFrame.origin.y)];
        [self setNeedsDisplay];
    }
}

- (BOOL)setCursorPoint:(CGPoint)point
{
    if (!CGRectContainsPoint(rcChartFrame, point))
    {
        return NO;
    }
    NSInteger column = (point.x - rcChartFrame.origin.x) / _chartData.columnWidth;
    if (column >= _chartData.columnCount)
    {
        if (_chartData.columnCount > 0)
        {
            column = _chartData.columnCount - 1;
        }
        else
        {
            return NO;
        }
    }
    _chartData.currentPoint = CGPointMake(rcChartFrame.origin.x + _chartData.columnWidth * column, point.y);
    _currentColumn = column;
    //[self setNeedsDisplay];//等到识别到长按手势后调用
    return YES;
}

- (BOOL)zoomCurve:(BOOL)isShrink centerX:(NSInteger)pointX
{
    NSInteger maxCount = rcChartFrame.size.width / _chartData.columnWidth;
    NSInteger rightColumn = (_chartData.columnStart + maxCount > _chartData.pointCount) ? _chartData.pointCount : (_chartData.columnStart + maxCount);
    if (isShrink)
    {
        if (_chartData.columnWidth > CHART_WIDTH_MIN)
        {
            _chartData.columnWidth -= CHART_WIDTH_STEP;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        if (_chartData.columnWidth < CHART_WIDTH_MAX)
        {
            _chartData.columnWidth += CHART_WIDTH_STEP;
        }
        else
        {
            return NO;
        }
    }
    _chartData.columnCount = rcChartFrame.size.width / _chartData.columnWidth;
    if (_chartData.columnCount >= _chartData.pointCount)
    {
        _chartData.columnCount = _chartData.pointCount;
        _chartData.columnStart = 0;
    }
    else
    {
        _chartData.columnStart = rightColumn - _chartData.columnCount;

        if (_chartData.columnStart + _chartData.columnCount > _chartData.pointCount)
        {
            _chartData.columnStart = _chartData.pointCount - _chartData.columnCount;
        }

        if (_chartData.columnStart < 0)
        {
            _chartData.columnStart = 0;
        }
    }

    [_chartData calculateCurveData];
    [self setCursorPoint:_chartData.currentPoint];
    [self setNeedsDisplay];
    return YES;
}
@end
