//
//  ifmChartSuspensionComponent.h
//  RJLTestPro
//
//  Created by mini on 2016/10/13.
//  Copyright © 2016年 renjialiang. All rights reserved.
//
#import "CurveSuspensionView.h"
#import "ifmChartComponent.h"
typedef NS_ENUM(NSUInteger, SuspensionType) {
    SuspensionShuPingType = 0,
    SuspensionHengPingType
};
@interface ifmChartSuspensionComponent : ifmChartComponent
- (instancetype)initSusType:(SuspensionType)type curveType:(CurveSuspensionType)curveType;
@end
