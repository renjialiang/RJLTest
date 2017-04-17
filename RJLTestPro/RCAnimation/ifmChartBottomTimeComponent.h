//
//  ifmChartBottomTimeComponent.h
//  RJLTestPro
//
//  Created by mini on 2016/10/13.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartComponent.h"

typedef NS_ENUM(NSUInteger, TimeCountType) {
    TimeCount_None = 0,
    TimeCountLeftAndRight,
    TimeCountLeftMidRight,
};
@interface ifmChartBottomTimeComponent : ifmChartComponent
@property (nonatomic) TimeCountType countType;
@property (nonatomic, strong) UIColor *timeColor;
@property (nonatomic, strong) UIFont *timeFont;
@end
