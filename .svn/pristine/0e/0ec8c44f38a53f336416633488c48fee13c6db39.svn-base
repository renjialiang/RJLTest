//
//  CurveSuspensionView.h
//  AMHexin
//
//  Created by mini on 16/9/9.
//
//

#import <UIKit/UIKit.h>
#define KLINEINDICATORCOUNT 7
#define FENSHIINDICATORCOUNT 5
#define FENSHIGUZHIINDICATORCOUNT 4
#define FUNDINDICATORCOUNT 4
#define SIMUINDICATORCOUNT 3
#define SUSPENSIONVIEWHEIGHT 34
#define SHUPINGSUSPENSIONVIEWHEIGHT 17
typedef NS_ENUM(NSInteger, CurveSuspensionType) {
    CurveSuspensionKline = 0,
    CurveSuspensionFenShi = 1,
    CurveSuspensionGuZhiFenShi = 2,
    CurveSuspensionQiZhiFenShi = 3,
    CurveSuspensionNetValue = 4,
    CurveSuspensionYearsIncome = 5,
    CurveSuspensionSiMuNetValue = 6,
};

@interface CurveSuspensionView : UIView
- (instancetype)initWithFrame:(CGRect)frame suspensionType:(CurveSuspensionType)type;
- (void)showCurveIndicatorData:(NSDictionary *)infoArray;
- (instancetype)initWithFrame:(CGRect)frame suspensionType:(CurveSuspensionType)type shuPing:(BOOL)isShuPing;
@end
