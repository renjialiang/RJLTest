//
//  ifmChartData.h
//  RJLTestPro
//
//  Created by mini on 2016/10/9.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define CHART_WIDTH_MAX 15
#define CHART_WIDTH_STEP 0.5
#define CHART_WIDTH_MIN 1
#define ZOOM_MOVE_WIDTH_VERTICAL 15
#define FAILDMAX 4294967290

static const NSString *CURVEDATA = @"data";
static const NSString *CHARTNAME = @"name";
static const NSString *CURVECOLOR = @"curvecolor";
static const NSString *CURVETYPE = @"showtype";
static const NSString *CURVEPOINT = @"points";

typedef NS_ENUM(NSUInteger, DrawCurveType) //曲线绘制的种类
{
    DrawCurveType_None = 0,
    DrawCurveType_PointLine //点连线，如均线
};

typedef NS_ENUM(NSUInteger, ChartType) {
    ChartAssessmentType, //实时估值
};
@interface ifmChartData : NSObject
@property (nonatomic, strong) NSDictionary *lineData;
@property (nonatomic, strong, readonly) NSMutableArray *curveData;
@property (nonatomic) NSInteger pointCount;
@property (nonatomic) CGRect curveRect;

@property (nonatomic) CGFloat columnWidth;
@property (nonatomic) NSInteger columnStart;
@property (nonatomic) NSInteger columnCount;

@property (nonatomic, readwrite) CGFloat paddingLeft;
@property (nonatomic, readwrite) CGFloat paddingTop;
@property (nonatomic, readwrite) CGFloat paddingRight;
@property (nonatomic, readwrite) CGFloat paddingBottom;

@property (nonatomic, readwrite) CGFloat borderHorCount;
@property (nonatomic, readwrite) CGFloat borderVerCount;

@property (nonatomic) BOOL needCross;
@property (nonatomic) CGPoint currentPoint; //当前察看的点坐标

@property (nonatomic) NSInteger decimal;

- (instancetype)initChartType:(ChartType)type;
- (instancetype)initWithConfigFile:(NSString *)fileName;
- (void)calculateCurveData;
- (CGFloat)getValueMax;
- (CGFloat)getValueMin;
- (ChartType)getChartType;
@end
