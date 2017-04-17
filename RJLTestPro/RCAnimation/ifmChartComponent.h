//
//  ifmChartComponent.h
//  RJLTestPro
//
//  Created by mini on 2016/10/9.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "iFMCurveDrawTool.h"
#import "ifmChartData.h"
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ChartDrawType) {
    draw_in_left,
    draw_in_top,
    draw_in_right,
    draw_in_bottom,
    draw_in_graph
};
@interface ifmChartComponent : NSObject
@property (nonatomic) ChartDrawType drawType;
- (void)draw:(UIView *)superView chartContext:(CGContextRef)context chartRect:(CGRect)rect chartData:(ifmChartData *)data;
@end
