//
//  RJLPublicTool.h
//  RJLTestPro
//
//  Created by mini on 16/5/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RJLPublicTool : NSObject
/**
 *  根据字符串得到实际尺寸
 *
 *  @param size 最大展示尺寸
 *  @param text 文本
 *  @param font 文本字体
 *
 *  @return 实际尺寸
 */
+ (CGSize)boundingRectWithSize:(CGSize)size andText:(NSString *)text andTextFont:(UIFont*)font;
/**
 *  根据字符串得到实际Label尺寸
 *
 *  @param useFont  文本字体
 *  @param text     文本
 *  @param padding  文本行距
 *  @param realSize 最大展示尺寸
 *
 *  @return 实际尺寸
 */
+ (CGSize)getHeightWithUseFont:(UIFont *)useFont andWithContent:(NSString *)text andWithPadding:(CGFloat)padding andWithUseRect:(CGSize)realSize;
@end
