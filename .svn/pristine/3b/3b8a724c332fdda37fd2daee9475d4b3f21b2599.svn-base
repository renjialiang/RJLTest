//
//  ifmChartData.m
//  RJLTestPro
//
//  Created by mini on 2016/10/9.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartData.h"

@interface ifmChartData ()
@property (nonatomic, readwrite) CGFloat valueMax;
@property (nonatomic, readwrite) CGFloat valueMin;
@property (nonatomic, readwrite) ChartType type;
@end

@implementation ifmChartData
- (instancetype)initChartType:(ChartType)type
{
    self = [super init];
    if (self)
    {
        self.type = type;
        [self initializationValue];
    }
    return self;
}

- (void)initializationValue
{
    self.paddingLeft = 0;
    self.paddingTop = 0;
    self.paddingRight = 0;
    self.paddingBottom = 0;
    self.borderHorCount = 0;
    self.borderVerCount = 0;
    self.pointCount = 0;
    self.valueMax = 0;
    self.valueMin = 0;
    self.columnCount = 0;
    self.columnStart = 0;
    self.columnWidth = 0;
    self.curveRect = CGRectZero;
    self.currentPoint = CGPointZero;
}

- (instancetype)initWithConfigFile:(NSString *)fileName
{
    self = [super init];
    if (self)
    {
        [self initializationValue];
        [self readConfigFile:fileName];
    }
    return self;
}

- (void)readConfigFile:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    if (data)
    {
        NSDictionary *jsonConfig = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (jsonConfig && jsonConfig.count > 0)
        {
            for (NSString *key in [jsonConfig allKeys])
            {
                if ([key isEqualToString:@"paddingLeft"])
                {
                    self.paddingLeft = [[jsonConfig objectForKey:key] floatValue];
                }
                else if ([key isEqualToString:@"paddingTop"])
                {
                    self.paddingTop = [[jsonConfig objectForKey:key] floatValue];
                }
                else if ([key isEqualToString:@"paddingRight"])
                {
                    self.paddingRight = [[jsonConfig objectForKey:key] floatValue];
                }
                else if ([key isEqualToString:@"paddingBottom"])
                {
                    self.paddingBottom = [[jsonConfig objectForKey:key] floatValue];
                }
                else if ([key isEqualToString:@"borderHorCount"])
                {
                    self.borderHorCount = [[jsonConfig objectForKey:key] floatValue];
                }
                else if ([key isEqualToString:@"borderVerCount"])
                {
                    self.borderVerCount = [[jsonConfig objectForKey:key] floatValue];
                }
                else if ([key isEqualToString:@"ChartType"])
                {
                    self.type = [[jsonConfig objectForKey:key] floatValue];
                }
                else if ([key isEqualToString:@"decimal"])
                {
                    self.decimal = [[jsonConfig objectForKey:key] integerValue];
                }
            }
        }
    }
}

- (CGFloat)getValueMax
{
    return _valueMax;
}

- (CGFloat)getValueMin
{
    return _valueMin;
}

- (ChartType)getChartType
{
    return _type;
}

- (void)setLineData:(NSDictionary *)lineData
{
    if (self.lineData)
    {
        self.lineData = nil;
    }
    _lineData = [[NSMutableDictionary alloc] initWithDictionary:lineData];
    [self handleChartData];
}

- (void)handleChartData
{
    if (!_lineData || _lineData.count == 0)
    {
        return;
    }
    _pointCount = ((NSArray *)[_lineData objectForKey:CURVEDATA]).count;
    CGFloat realWidth = 1;
    if (self.type == ChartAssessmentType)
    {
        realWidth = _curveRect.size.width / 242;
    }
    else
    {
        realWidth = _curveRect.size.width / _pointCount;
    }
    if (realWidth > CHART_WIDTH_MIN)
    {
        if (realWidth > ZOOM_MOVE_WIDTH_VERTICAL)
        {
            _columnWidth = ZOOM_MOVE_WIDTH_VERTICAL;
        }
        else
        {
            _columnWidth = realWidth;
        }
    }
    _columnCount = _curveRect.size.width / _columnWidth + 1; //宽度决定到显示的多少个点
    if (_columnCount > _pointCount)
    {
        _columnCount = _pointCount;
        _columnStart = 0;
    }
    else
    {
        _columnStart = _pointCount - _columnCount;
    }
    [self calculateCurveData];
}

- (void)calculateCurveData
{
    [self createDataType:self.type customParams:nil];
    [self calculateValueLimit];
    [self convertDataToObject:_curveData];
}

- (void)createDataType:(ChartType)type customParams:(NSArray *)params
{
    if (_curveData != NULL && _curveData.count > 0)
    {
        [_curveData removeAllObjects];
        _curveData = nil;
    }

    switch (type)
    {
        case ChartAssessmentType:
        {
            _curveData = [[NSMutableArray alloc] initWithCapacity:1];

            NSMutableDictionary *dicParamsOne = [NSMutableDictionary dictionary];
            [dicParamsOne setObject:@"实时估值" forKey:CHARTNAME];
            [dicParamsOne setObject:[UIColor blueColor] forKey:CURVECOLOR];
            [dicParamsOne setObject:[NSNumber numberWithInteger:DrawCurveType_PointLine] forKey:CURVETYPE];

            NSArray *lineArray = [_lineData objectForKey:CURVEDATA];
            NSMutableArray *curveDataArray = [[NSMutableArray alloc] initWithCapacity:1];
            NSMutableArray *saveLineArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
            for (NSInteger index = 0; index < _columnCount; index++)
            {
                NSUInteger indexEx = _columnStart + index;
                double tmp = [[lineArray objectAtIndex:indexEx] doubleValue];
                if (tmp >= FILENAME_MAX)
                {
                    tmp = 0;
                }
                [saveLineArray addObject:[NSNumber numberWithDouble:tmp]];
            }
            [curveDataArray addObject:saveLineArray];
            [dicParamsOne setObject:curveDataArray forKey:CURVEDATA];
            [_curveData addObject:dicParamsOne];
            break;
        }
        default:
            break;
    }
}

- (void)calculateValueLimit
{
    NSMutableArray *curveDataArray = [[_curveData objectAtIndex:0] objectForKey:CURVEDATA];
    for (int index = 0; index < curveDataArray.count; index++)
    {
        if ([[[_curveData objectAtIndex:0] objectForKey:CURVETYPE] integerValue] == DrawCurveType_None)
        {
            continue;
        }
        NSMutableArray *lineDataArray = [curveDataArray objectAtIndex:index];
        CGFloat maxValue = [[lineDataArray valueForKeyPath:@"@max.floatValue"] floatValue];
        CGFloat minValue = [[lineDataArray valueForKeyPath:@"@min.floatValue"] floatValue];
        if (maxValue > _valueMax)
        {
            _valueMax = maxValue;
        }
        if (minValue < _valueMin || _valueMin == 0)
        {
            _valueMin = minValue;
        }
    }
}

- (void)convertDataToObject:(NSMutableArray *)menager
{
    NSMutableDictionary *curveInfoDic = [[menager objectAtIndex:0] mutableCopy];
    NSMutableArray *curveDataArray = [curveInfoDic objectForKey:CURVEDATA];
    for (int index = 0; index < curveDataArray.count; index++)
    {
        DrawCurveType type = [[curveInfoDic objectForKey:CURVETYPE] integerValue];
        NSMutableArray *valueArray = [curveDataArray objectAtIndex:index];
        NSMutableArray *pointArray = [[NSMutableArray alloc] initWithCapacity:valueArray.count];
        switch (type)
        {
            case DrawCurveType_PointLine:
            {
                if (valueArray.count <= 0)
                {
                    break;
                }
                CGRect rect = _curveRect;
                CGFloat valueMax, valueMin;
                valueMax = _valueMax;
                valueMin = _valueMin;
                if (valueMax == CGFLOAT_MAX || valueMin == -CGFLOAT_MAX)
                {
                    break;
                }
                CGFloat cellWidth = _columnWidth;
                if (cellWidth < 0)
                {
                    cellWidth = 1;
                }
                CGPoint topleft = rect.origin;
                CGPoint curPoint;
                for (int i = 0; i < _columnCount; i++)
                {
                    curPoint.x = topleft.x + i * cellWidth;
                    CGFloat divider = valueMax - valueMin;
                    if (divider == 0)
                    {
                        curPoint.y = topleft.y + rect.size.height * 0.5;
                    }
                    else
                    {
                        curPoint.y = topleft.y + rect.size.height * (valueMax - [[valueArray objectAtIndex:i] floatValue]) / divider;
                    }
                    if (curPoint.y < (topleft.y + rect.size.height) && curPoint.y > (topleft.y + rect.size.height - 1))
                    {
                        curPoint.y = (topleft.y + rect.size.height - 1);
                    }
                    [pointArray addObject:[NSValue valueWithCGPoint:curPoint]];
                }
                [curveInfoDic setObject:pointArray forKey:CURVEPOINT];
                [_curveData replaceObjectAtIndex:0 withObject:curveInfoDic];
                break;
            }
            default:
                break;
        }
    }
}

@end
