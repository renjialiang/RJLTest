//
//  RJLThemeManager.m
//  RJLTestPro
//
//  Created by mini on 16/8/1.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLThemeManager.h"
#import <objc/runtime.h>
#import "RJLThemeConstant.h"
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
void MethodSwizzle(Class aClass, SEL orig_sel, SEL alt_sel) {
	
	Method orig_method = nil, alt_method = nil;
	
	// First, look for the methods
	orig_method = class_getInstanceMethod(aClass, orig_sel);
	alt_method = class_getInstanceMethod(aClass, alt_sel);
	
	// If both are found, swizzle them
	if ((orig_method != nil) && (alt_method != nil))
	{
		IMP originIMP = method_getImplementation(orig_method);
		IMP altIMP = method_setImplementation(alt_method, originIMP);
		method_setImplementation(orig_method, altIMP);
	}
}
@implementation RJLThemeManager

- (instancetype)init
{
	if (self = [super init]) {
		NSString *resourcePath = [NSBundle mainBundle].resourcePath;
		NSString *styleFilePath = [NSString stringWithFormat:@"%@/%@", resourcePath, HbbUIStyleHelperMainHbbUIStyleName];
		NSDictionary *styleDict = [NSDictionary dictionaryWithContentsOfFile:styleFilePath];
		self.styleDict = styleDict;
		
	}
	return self;
}
+ (RJLThemeManager *)shareInstance
{
	static RJLThemeManager* themeManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		themeManager = [[RJLThemeManager alloc] init];
//		queueManager->_concurrentQueue = dispatch_queue_create(ConcurrentQueue, DISPATCH_QUEUE_CONCURRENT);
//		queueManager->_serialQueue = dispatch_queue_create(SerialQueue, DISPATCH_QUEUE_SERIAL);
	});
	return themeManager;
}

- (void)setStyleDict:(NSDictionary *)styleDict
{
	_styleDict = styleDict;
	_fontSytleDict = [styleDict objectForKey:kHbbUIStyleFontSizeStyle];
	_colorStyleDict = [styleDict objectForKey:kHbbUIStyleColorStyle];
	_imageSytleDict = [styleDict objectForKey:kHbbUIStyleImageStyle];
	_sizeSytleDict = [styleDict objectForKey:kHbbUIStyleSizeStyle];
}

- (void)changeStyleWithStyleDictionary:(NSDictionary *)styleDictionary
{
	self.styleDict = styleDictionary;
	
	//send a change style notification
	[[NSNotificationCenter defaultCenter] postNotificationName:HbbUIStyleHelperChangeStyleNotificationName object:nil];
}

+ (NSInteger)fontSizeWithKey:(NSString *)key
{
	NSNumber *value = [[RJLThemeManager shareInstance].fontSytleDict objectForKey:key];
	NSInteger fieSize = 0;
	if (value != nil) {
		fieSize = [value integerValue];
	}
	return fieSize;
}

+ (UIColor *)colorWithKey:(NSString *)key
{
	NSString *value = [[RJLThemeManager shareInstance].colorStyleDict objectForKey:key];
	UIColor *color = nil;
	if (value != nil && [value isEqualToString:@""] == NO) {
		//先以16为参数告诉strtoul字符串参数表示16进制数字，然后使用0x%X转为数字类型
		long long longlongvalue = strtoul([value UTF8String],0,16);
		color = UIColorFromRGB(longlongvalue);
	}
	
	return color;
}

+ (UIImage *)imageWithKey:(NSString *)key;
{
	NSString *value = [[RJLThemeManager shareInstance].imageSytleDict objectForKey:key];
	UIImage *image = nil;
	if (value != nil && [value isEqualToString:@""] == NO) {
		image = [UIImage imageNamed:value];
	}
	
	return image;
}

+ (CGFloat)sizeWithKey:(NSString *)key
{
	NSNumber *value = [[RJLThemeManager shareInstance].imageSytleDict objectForKey:key];
	CGFloat size = 0.0f;
	if (value != nil) {
		size = [value floatValue];
	}
	
	return size;
}

@end
