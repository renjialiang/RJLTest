//
//  ShuPingSuspensionView.m
//  RJLTestPro
//
//  Created by mini on 2016/10/13.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ShuPingSuspensionView.h"

@interface ShuPingSuspensionView ()
@property (nonatomic, strong) NSMutableArray *displayIndicatorArray;
@property (nonatomic) CurveSuspensionType currentType;
@end

@implementation ShuPingSuspensionView

- (instancetype)initWithFrame:(CGRect)frame suspensionType:(CurveSuspensionType)type
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.currentType = type;
        [self initMySelf];
    }
    return self;
}

- (void)initMySelf
{
    if (_displayIndicatorArray)
    {
        [_displayIndicatorArray removeAllObjects];
        _displayIndicatorArray = nil;
    }
    _displayIndicatorArray = [[NSMutableArray alloc] initWithCapacity:KLINEINDICATORCOUNT];
    if (_currentType == CurveSuspensionFenShi)
    {
        [self preprocessLabelArray:FENSHIINDICATORCOUNT];
    }
    else if (_currentType == CurveSuspensionGuZhiFenShi)
    {
        [self preprocessLabelArray:FENSHIGUZHIINDICATORCOUNT];
    }
    else if (_currentType == CurveSuspensionQiZhiFenShi)
    {
        [self preprocessLabelArray:SIMUINDICATORCOUNT];
    }
    else if (_currentType == CurveSuspensionKline)
    {
        [self preprocessLabelArray:KLINEINDICATORCOUNT];
    }
    else if (_currentType == CurveSuspensionNetValue || _currentType == CurveSuspensionYearsIncome)
    {
        [self preprocessLabelArray:FUNDINDICATORCOUNT];
    }
    else if (_currentType == CurveSuspensionSiMuNetValue)
    {
        [self preprocessLabelArray:SIMUINDICATORCOUNT];
    }
}

- (void)preprocessLabelArray:(NSInteger)inNum
{
    CGRect realRect = self.frame;
    realRect.size.height = inNum * SHUPINGSUSPENSIONVIEWHEIGHT;
    self.frame = realRect;
    CGFloat width = self.frame.size.width;
    for (NSInteger index = 0; index < inNum; index++)
    {
        UILabel *indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SHUPINGSUSPENSIONVIEWHEIGHT * index, width, SHUPINGSUSPENSIONVIEWHEIGHT)];
        [indicatorLabel setTextColor:[UIColor blackColor]];
        [indicatorLabel setFont:[UIFont systemFontOfSize:12]];
        indicatorLabel.adjustsFontSizeToFitWidth = YES;
        [indicatorLabel setNumberOfLines:1];
        indicatorLabel.tag = index;
        [indicatorLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:indicatorLabel];
        [_displayIndicatorArray addObject:indicatorLabel];
    }
}

- (void)showCurveIndicatorData:(NSDictionary *)infoArray
{
    NSArray *textArray = [infoArray objectForKey:@"text"];
    if (textArray.count != _displayIndicatorArray.count)
    {
        return;
    }
    for (NSInteger index = 0; index < _displayIndicatorArray.count; index++)
    {
        UILabel *indicLabel = [_displayIndicatorArray objectAtIndex:index];
        if ([[textArray objectAtIndex:index] isKindOfClass:[NSAttributedString class]])
        {
            [indicLabel setAttributedText:[textArray objectAtIndex:index]];
        }
        else
        {
            [indicLabel setText:[textArray objectAtIndex:index]];
        }
    }
}

@end
