//
//  RJLIndicatorLabel.m
//  RJLTestPro
//
//  Created by mini on 16/5/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLIndicatorLabel.h"

@implementation RJLIndicatorLabel
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initLabelParam];
}

- (void)initLabelParam
{
    if (!self.openAutoResize)
    {
        return;
    }
    self.numberOfLines = 1;
    self.adjustsFontSizeToFitWidth = YES;
    if (self.minFontSize == 0)
    {
        self.minimumScaleFactor = 0.1;
    }
    else
    {
        self.minimumScaleFactor = self.minFontSize / self.font.pointSize;
    }
}

- (void)initSelf
{
    //	void* ret = (__bridge void*)objc_msgSend(self, @selector(asdfa1));
    //	double ret1 = *((double*)ret);
}
- (void)setControlValue:(NSString *)value
{
    self.text = value;
}
@end
