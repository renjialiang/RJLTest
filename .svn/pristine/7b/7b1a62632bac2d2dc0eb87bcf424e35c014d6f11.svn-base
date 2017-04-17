//
//  RJLThemeManager.h
//  RJLTestPro
//
//  Created by mini on 16/8/1.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
//默认样式资源文件名称
static NSString *HbbUIStyleHelperMainHbbUIStyleName = @"MainUIStyle.plist";

//样式发生变更通知名称
static NSString *HbbUIStyleHelperChangeStyleNotificationName = @"HbbUIStyleHelperChangeStyleNotificationName";
@interface RJLThemeManager : NSObject
@property (nonatomic, strong) NSDictionary *styleDict;

@property (nonatomic, strong, readonly) NSDictionary *fontSytleDict;
@property (nonatomic ,strong, readonly) NSDictionary *colorStyleDict;
@property (nonatomic, strong, readonly) NSDictionary *imageSytleDict;
@property (nonatomic, strong, readonly) NSDictionary *sizeSytleDict;

+ (RJLThemeManager *)shareInstance;
/**
 *  设置样式字典
 *
 *  @param styleDictionary 样式字典
 */
- (void)changeStyleWithStyleDictionary:(NSDictionary *)styleDictionary;

/**
 *  获取颜色样式
 *
 *  @param key 颜色样式key
 */
+ (UIColor*)colorWithKey:(NSString *)key;

/**
 *  获取文本样式
 *
 *  @param key 字体样式key
 */
+ (NSInteger)fontSizeWithKey:(NSString *)key;

/**
 *  获取图片样式
 *
 *  @param key 图片样式key
 */
+ (UIImage *)imageWithKey:(NSString *)key;


/**
 *  获取尺寸样式
 *
 *  @param key 尺寸样式key
 */
+ (CGFloat)sizeWithKey:(NSString *)key;
@end
