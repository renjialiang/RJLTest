//
//  ifmChart.h
//  RJLTestPro
//
//  Created by mini on 2016/10/9.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartComponent.h"
#import "ifmChartData.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TouchAction) //滑动操作
{
    TouchAction_None = 0,  //等待操作
    TouchAction_Click,     //移动整体曲线
    TouchAction_Move,      //单指移动
    TouchAction_DoubleMove //双指移动
};

typedef NS_ENUM(NSUInteger, MoveAction) {
    MoveAction_None = 0, //未确定操作对象
    MoveAction_Curve,    //移动整体曲线
    MoveAction_Cursor    //移动光标
};
@interface ifmChart : UIView
{
    CGRect rcTopScale;    //图形上区域
    CGRect rcLeftScale;   //图形左区域
    CGRect rcRightScale;  //图形右区域
    CGRect rcBottomScale; //图形下区域
    CGRect rcChartFrame;
	
    NSInteger _currentColumn;    //当前察看的点 从可显示的开始
    NSInteger _startTime;
    CGSize _touchSize;   //上次两点间距
    CGPoint _touchPoint; //上次单点位置
    NSInteger _touchCount;     //停留在屏幕的手指数
    TouchAction _touchAction;
    MoveAction _moveAction;
}
@property (nonatomic, strong) NSMutableArray *components;
@property (nonatomic, strong) ifmChartData *chartData;
@property (nonatomic) BOOL moveSwitch;
- (void)refreshCurrentChart;
- (instancetype)initWithFrame:(CGRect)frame chartData:(ifmChartData *)data;
- (void)setChartComponent:(ifmChartComponent *)component;
- (void)setChartCurveData:(NSDictionary *)dicData;
@end
