//
//  iFMCurveDrawTool.h
//  framework
//
//  Created by RenJialiang on 15-7-30.
//  Copyright (c) 2015年 wxzy. All rights reserved.
//
#ifndef _CurveObjectTool_h_include
#define _CurveObjectTool_h_include
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define NORMAL_FONT_SIZE 12

#define Curve_Color_Red RGBA(200, 0, 0, 255)
#define Curve_Color_Green RGBA(0, 104, 0, 255)
#define Curve_Color_Black RGBA(0, 0, 0, 255)
#define Curve_Color_White RGBA(255, 255, 255, 255)
#define Curve_Color_Blue RGBA(2, 226, 244, 255)
#define Curve_Color_Yellow RGBA(239, 198, 64, 255)
#define Curve_Color_Red_For_Trend RGBA(254, 25, 25, 255)
#define Curve_Color_Green_For_Trend RGBA(46, 178, 33, 255)
#define Curve_Color_For_Grid RGBA(180, 180, 180, 255)
#define Curve_Color_Cover RGBA(235, 231, 228, 255)
#define UIColorFromRGBA(rgbValue, alphaVaule) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0x00FF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0x0000FF)) / 255.0 alpha:alphaVaule]
#define FLOAT_MAX CGFLOAT_MAX
#define FLOAT_MIN -CGFLOAT_MAX
#define YI 100000000
#define WAN 10000

@interface iFMCurveDrawTool : NSObject
+ (NSString *)getEncodeUrlString:(NSString *)orign;
//UTF8 转换Unicode编码
+ (NSString *)replaceUnicode:(NSString *)aUnicodeString;
//Unicode 转换UTF8编码
+ (NSString *)utf8ToUnicode:(NSString *)string;
//16进制颜色转换UIColor
+ (UIColor *)getColorWithHexValue:(NSString *)hexColor;
//绘制曲线
+ (void)drawCurve:(CGContextRef)context pointArray:(CGPoint *)points arrayCount:(NSUInteger)count lineColor:(CGColorRef)color lineWidth:(float)width;
//绘制曲线去掉坏点
+ (void)drawCurveWithoutIvnalidPoints:(CGContextRef)context pointArray:(CGPoint *)points arrayCount:(int)count lineColor:(CGColorRef)color;
//绘制多色曲线去掉坏点
+ (void)drawColorfulCurveWithoutInvalidPoints:(CGContextRef)context pointArray:(CGPoint *)points arrayCount:(int)count lineColor:(int *)colors;
//绘制文字
+ (int)drawText:(CGContextRef)context text:(NSString *)str textRect:(CGRect)rect textColor:(CGColorRef)color textFont:(UIFont *)font alignMent:(NSTextAlignment)align;
//绘制竖线
+ (void)drawSeriesLine:(CGContextRef)context pointArray:(CGPoint *)points arrayCount:(int)count baseY:(int)coordY lineColor:(CGColorRef *)color;
//根据像素值绘制横线
+ (void)drawPixelHorizontal:(CGContextRef)context pointBegin:(CGPoint)point lineLength:(int)length lineWidth:(int)width color:(CGColorRef)color;
//根据像素值绘制竖线
+ (void)drawPixelVertical:(CGContextRef)context pointBegin:(CGPoint)point lineLength:(int)length lineWidth:(int)width color:(CGColorRef)color;
//根据像素绘制矩形
+ (void)drawPixelRect:(CGContextRef)context rectDraw:(CGRect)rect color:(CGColorRef)color;
//绘制水平虚线
+ (void)drawDashedLineHorizontal:(CGContextRef)context pointBegin:(CGPoint)point lineLength:(int)length color:(CGColorRef)color;
//绘制垂直虚线
+ (void)drawDashedLineVertical:(CGContextRef)context pointBegin:(CGPoint)point lineLength:(int)length color:(CGColorRef)color;
//绘制K线红绿柱
+ (void)drawKLineColumn:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB ptMax:(CGPoint)ptMax ptMin:(CGPoint)ptMin color:(CGColorRef)color isFill:(BOOL)isFill;
//绘制红绿柱
+ (void)drawColumn:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB color:(CGColorRef)color isFill:(BOOL)isFill;
//绘制布林线的布林带
+ (void)drawBollLine:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB ptMax:(CGPoint)ptMax ptMin:(CGPoint)ptMin color:(CGColorRef)color;
//绘制乾坤线（大盘晴雨表）
+ (void)drawDPQYB:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB color:(CGColorRef)color;
//绘制三角形
+ (void)drawTriangle:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB ptRectC:(CGPoint)ptRectC color:(CGColorRef)color isFill:(BOOL)isFill;
//绘制箭头
+ (void)drawArrow:(CGContextRef)context rectDraw:(CGRect)rect color:(CGColorRef)color bUpOrDown:(BOOL)bUpOrDown isFill:(BOOL)isFill;
//绘制光标
+ (void)drawCursor:(CGContextRef)context ptCursor:(CGPoint)point xValue:(NSString *)xValue xColor:(CGColorRef)xColor yValue:(NSString *)yValue yColor:(CGColorRef)yColor topRect:(CGRect)topRect bottomRect:(CGRect)bottomRect textFont:(UIFont *)font;
//绘制股指分时光标
+ (void)drawGuzhiFenShiCursor:(CGContextRef)context ptCursor:(CGPoint)point xValue:(NSString *)xValue xColor:(CGColorRef)xColor yValue:(NSString *)yValue yColor:(CGColorRef)yColor topRect:(CGRect)topRect bottomRect:(CGRect)bottomRect textFont:(UIFont *)font;
//绘制个股分时光标
+ (void)drawFenShiCursor:(CGContextRef)context ptCursor:(CGPoint)point xValue:(NSString *)xValue xColor:(CGColorRef)xColor yValue:(NSString *)yValue yColor:(CGColorRef)yColor topRect:(CGRect)topRect bottomRect:(CGRect)bottomRect textFont:(UIFont *)font;
//绘制点取整修正
+ (CGPoint)adjustPoint:(CGPoint)point;
//计算字体尺寸
+ (CGSize)calTextSize:(UIFont *)font text:(NSString *)text;
//绘制图片
+ (void)drawIcon:(CGContextRef)context image:(NSString *)image rect:(CGRect)rect;
//绘制圆角矩形
+ (void)drawRoundedRect:(CGContextRef)context rect:(CGRect)rect ovalWidth:(float)ovalWidth ovalHeight:(float)ovalHeight;
//创建uiColor 获取cgColor 不需要自己释放
+ (UIColor *)uicolorWithInt:(int)color;
+ (CGColorRef)cgcolorWithInt:(int)color;

+ (UIColor *)getColorWithlong:(long)color;

//根据16进制颜色参数得到CGColorRef
+ (CGColorRef)cgcolorWithlong:(long)color;

//绘制CGRect区域中的椭圆
+ (void)FillEllipse:(CGContextRef)context
            setRect:(CGRect)rect
       setFillColor:(CGColorRef)fillColor
        setPanColor:(CGColorRef)panColor;

//绘制扇形图
+ (BOOL)DrawSector:(CGContextRef)context setRect:(CGRect)rt setDegreeFrom:(int)nDegreeFrom setDegreeTo:(int)nDegreeTo setbFill:(BOOL)bFill setPanColor:(CGColorRef)panColor setFillColor:(CGColorRef)FillColor;

+ (void)DrawGradientArea:(CGContextRef)context setColor:(UIColor **)colors setCGRect:(CGRect)rect setlocations:(CGFloat *)locations
                setCount:(int)count;

//根据两个点画线
+ (void)drawLineByPoint:(CGContextRef)context startPoint:(CGPoint)pointOne desPoint:(CGPoint)pointTwo lineWidth:(int)width color:(CGColorRef)color;
+ (NSString *)ChangeValueFormat:(double)value decimalBit:(NSInteger)decimal carryBit:(BOOL)carry;
//画一个圆形
+ (void)drawCircle:(CGContextRef)context andCenter:(CGPoint)point andRadius:(CGFloat)radius;

+ (CGSize)getHeightWithUseFont:(UIFont *)useFont andWithContent:(NSString *)text andWithPadding:(CGFloat)padding andWithUseRect:(CGSize)realSize;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)drawDash:(CGSize)contextSize andLineLength:(const CGFloat *)lengths andColor:(UIColor *)lineColor andHorizontal:(BOOL)horizontal;
@end

#endif
