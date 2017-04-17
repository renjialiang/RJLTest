//
//  RJLIndicatorStretchLabel.h
//  RJLTestPro
//
//  Created by mini on 16/5/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJLIndicatorStretchLabel : UILabel
@property (nonatomic, copy) NSString	*dataId;
@property (nonatomic) NSInteger maxCol;
@property (nonatomic) CGFloat   defaultHeight;
@property (nonatomic) BOOL isSetColor;//是否设置颜色
/**
 *  设置展示数据
 *
 *  @param value 字符串
 */
- (void)setControlValue:(NSString *)value;
@end
