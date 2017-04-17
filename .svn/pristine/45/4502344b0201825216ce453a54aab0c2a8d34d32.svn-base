//
//  ifmChartSuspensionComponent.m
//  RJLTestPro
//
//  Created by mini on 2016/10/13.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "ifmChartSuspensionComponent.h"
@interface ifmChartSuspensionComponent ()
@property (nonatomic) SuspensionType susType;
@property (nonatomic) CurveSuspensionType curSusType;
@property (nonatomic, strong) CurveSuspensionView *suspensView;
@end
@implementation ifmChartSuspensionComponent
- (instancetype)initSusType:(SuspensionType)type curveType:(CurveSuspensionType)curveType
{
    self = [super init];
    if (self)
    {
        self.susType = type;
        self.curSusType = curveType;
    }
    return self;
}

- (void)initMyView:(UIView *)superView
{
    if (self.susType == SuspensionShuPingType)
    {
        _suspensView = [[CurveSuspensionView alloc] initWithFrame:CGRectMake(0, 0, 80, SHUPINGSUSPENSIONVIEWHEIGHT) suspensionType:self.curSusType shuPing:YES];
        [_suspensView setBackgroundColor:[UIColor redColor]];
        [superView addSubview:_suspensView];
    }
    else if (self.susType == SuspensionHengPingType)
    {
        _suspensView = [[CurveSuspensionView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, SUSPENSIONVIEWHEIGHT) suspensionType:CurveSuspensionNetValue];
        [_suspensView setBackgroundColor:[UIColor colorWithRed:242 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
        //				[([HQPageTabber getHQPageTabber:self]).superview addSubview:_suspensionView];
    }
    _suspensView.hidden = YES;
}

- (void)draw:(UIView *)superView chartContext:(CGContextRef)context chartRect:(CGRect)rect chartData:(ifmChartData *)data
{
    if (!data.needCross)
    {
        if (_suspensView)
        {
            _suspensView.hidden = YES;
        }
    }
    if (data.columnCount == 0)
    {
        return;
    }
    if (self.suspensView == nil)
    {
        [self initMyView:superView];
    }
    if (data.needCross)
    {
        if (self.susType == SuspensionShuPingType)
        {
            if (data.currentPoint.x < rect.size.width / 2 + rect.origin.x)
            {
                CGRect rc = _suspensView.frame;
                rc.origin.x = rect.origin.x + rect.size.width - _suspensView.frame.size.width;
                rc.origin.y = rect.origin.y;
                _suspensView.frame = rc;
            }
            else
            {
                CGRect rc = _suspensView.frame;
                rc.origin.x = rect.origin.x;
                rc.origin.y = rect.origin.y;
                _suspensView.frame = rc;
            }
            _suspensView.hidden = NO;

            NSMutableArray *textArray = [NSMutableArray array];

            NSString *netValueText = @"净值:";
            double valueShou = 123123;
            if (valueShou == FLOAT_MIN)
            {
                netValueText = [netValueText stringByAppendingString:@"--"];
            }
            else
            {
                netValueText = [netValueText stringByAppendingString:[iFMCurveDrawTool ChangeValueFormat:valueShou decimalBit:4 carryBit:NO]];
            }
            UIColor *newValueColor = [UIColor colorWithRed:37 / 255.0 green:225 / 255.0 blue:242 / 255.0 alpha:1.0];
            NSMutableAttributedString *netValueString = [[NSMutableAttributedString alloc] initWithString:netValueText];
            [netValueString addAttributes:[NSDictionary dictionaryWithObject:newValueColor forKey:NSForegroundColorAttributeName] range:NSMakeRange(3, netValueString.length - 3)];
            [textArray addObject:netValueString];

            NSString *valueStandardText = @"基准:";
            double valueStandard = 123123;
            //			if (_valueFailed) {
            //				valueStandardText = [valueStandardText stringByAppendingString:@"--"];
            //			}
            //			else {
            valueStandardText = [valueStandardText stringByAppendingString:[iFMCurveDrawTool ChangeValueFormat:valueStandard decimalBit:4 carryBit:NO]];
            //			}
            UIColor *valueStandardColor = [UIColor redColor];
            NSMutableAttributedString *valueStandardString = [[NSMutableAttributedString alloc] initWithString:valueStandardText];
            [valueStandardString addAttributes:[NSDictionary dictionaryWithObject:valueStandardColor forKey:NSForegroundColorAttributeName] range:NSMakeRange(3, valueStandardString.length - 3)];
            [textArray addObject:valueStandardString];

            NSString *zhangdieText = @"涨幅:";
            CGFloat increasePercent = 12313;
            zhangdieText = [zhangdieText stringByAppendingString:[NSString stringWithFormat:@"%.2f%%", increasePercent]];
            UIColor *zhangdiefuValueColor = [UIColor redColor]; //[self getSubWithNumberOne:increasePercent numberTwo:0];
            NSMutableAttributedString *zhangdiefuAttributedText = [[NSMutableAttributedString alloc] initWithString:zhangdieText];
            if (zhangdiefuValueColor)
            {
                [zhangdiefuAttributedText addAttribute:NSForegroundColorAttributeName value:zhangdiefuValueColor range:NSMakeRange(3, zhangdiefuAttributedText.length - 3)];
            }
            [textArray addObject:zhangdiefuAttributedText];
            [_suspensView showCurveIndicatorData:@{ @"text" : textArray }];
        }
    }
}
@end
