//
//  CurveSuspensionView.m
//  AMHexin
//
//  Created by mini on 16/9/9.
//
//

#import "CurveSuspensionView.h"
//#import "SystemControl_Append.h"
@interface CurveSuspensionView ()
@property (nonatomic, strong) NSMutableArray *displayIndicatorArray;
@property (nonatomic) CurveSuspensionType currentType;
@property (nonatomic) BOOL isShuPing;
@end

@implementation CurveSuspensionView

- (instancetype)initWithFrame:(CGRect)frame suspensionType:(CurveSuspensionType)type shuPing:(BOOL)isShuPing
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.currentType = type;
        self.isShuPing = isShuPing;
        [self initMySelf];
    }
    return self;
}

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
    CGFloat width, height;
    if (_isShuPing)
    {
        CGRect realRect = self.frame;
        realRect.size.height = inNum * SHUPINGSUSPENSIONVIEWHEIGHT;
        self.frame = realRect;
        width = self.frame.size.width;
        height = SHUPINGSUSPENSIONVIEWHEIGHT;
    }
    else
    {
        width = self.frame.size.width / inNum;
        height = self.frame.size.height;
    }

    for (NSInteger index = 0; index < inNum; index++)
    {
        UILabel *indicatorLabel = [[UILabel alloc] init];
        if (_isShuPing)
        {
            [indicatorLabel setFrame:CGRectMake(0, height * index, width, height)];
        }
        else
        {
            [indicatorLabel setFrame:CGRectMake(width * index, 0, width, height)];
        }

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
