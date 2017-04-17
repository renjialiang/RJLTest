//
//  ShuPingSuspensionView.h
//  RJLTestPro
//
//  Created by mini on 2016/10/13.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "CurveSuspensionView.h"
#import <UIKit/UIKit.h>
#define SHUPINGSUSPENSIONVIEWHEIGHT 17
@interface ShuPingSuspensionView : UIView
- (instancetype)initWithFrame:(CGRect)frame suspensionType:(CurveSuspensionType)type;
- (void)showCurveIndicatorData:(NSDictionary *)infoArray;
@end
