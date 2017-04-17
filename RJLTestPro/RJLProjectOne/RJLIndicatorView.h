//
//  RJLIndicatorView.h
//  RJLTestPro
//
//  Created by mini on 16/5/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJLIndicatorView : UIView
//独立标识，与ViewTag区分
@property (nonatomic) NSUInteger tagEx;
//视图控制器集合
@property (nonatomic, readonly, strong) NSMutableDictionary		*dicControls;
//视图id数组
@property (nonatomic, readonly, strong) NSMutableArray			*dataIds;
/**
 *  查找视图控制器
 *
 *  @param dataId 视图id
 *
 *  @return 视图控制器
 */
- (UIView *)findControlById:(NSString*)dataId;
/**
 *  设置子视图数据
 *
 *  @param value  数据
 *  @param dataId 子视图id
 */
- (void)setControlValue:(id)value dataId:(NSString *)dataId;
@end
