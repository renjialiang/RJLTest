//
//  RJLRuntimeTools.h
//  RJLTestPro
//
//  Created by admin on 17/4/18.
//  Copyright © 2017年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface RJLRuntimeTools : NSObject
/**
 *  方法替换
 *
 *  @param aClass      方法类
 *  @param orig_sel    原有SEL
 *  @param swizzle_sel 替换SEL
 */
+ (void)MethodSwizzle:(nonnull Class)aClass andOrigSel:(nonnull SEL)orig_sel andSwizzleSel:(nonnull SEL)swizzle_sel;
/**
 *  修改成员变量
 *
 *  @param objClass   对象
 *  @param ivarName   成员变量名称
 *  @param changeIvar 变量值
 *
 *  @return YES NO
 */
+ (BOOL)changeFromClass:(nonnull id)objClass variableName:(nonnull NSString *)ivarName changeVariable:(nonnull id)changeIvar;

/**
 *  获取成员变量的值
 *
 *  @param objc     对象
 *  @param ivarName 成员变量名称
 *
 *  @return 变量值
 */
+ (nullable id)getIvarFromObject:(nonnull id)objc variableName:(nonnull NSString *)ivarName;

/**
 *  获取实例名称
 *
 *  @param instance 实例
 *
 *  @return 名称
 */
+ (nullable NSString *)nameFromObject:(nonnull id)objc withInstance:(nonnull id)instance;

@end
