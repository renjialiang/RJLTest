//
//  MTSingletonManager.m
//  RJLTestPro
//
//  Created by mini on 16/8/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "MTSingletonManager.h"
#import "CustomGridButton.h"
@implementation MTSingletonManager
+ (MTSingletonManager *)shareInstance
{
	static dispatch_once_t onceToken;
	static id _sInstance;
	dispatch_once(&onceToken, ^{
		_sInstance = [[self alloc] init];
	});
	return _sInstance;
}

- (void)setOtherGridIDArray:(NSMutableArray *)otherGridIDArray
{
	_otherGridIDArray = otherGridIDArray;
	[self saveLocalDataPersistence:otherGridIDArray keyValue:OtherHQTabID];
}

- (void)setOtherGridImageArray:(NSMutableArray *)otherGridImageArray
{
	_otherGridImageArray = otherGridImageArray;
	[self saveLocalDataPersistence:otherGridImageArray keyValue:OtherHQTabImage];
}

- (void)setOtherGridTitleArray:(NSMutableArray *)otherGridTitleArray
{
	_otherGridTitleArray = otherGridTitleArray;
	[self saveLocalDataPersistence:otherGridTitleArray keyValue:OtherHQTabTitle];
}

- (void)setDisplayGridIDArray:(NSMutableArray *)displayGridIDArray
{
	_displayGridIDArray = displayGridIDArray;
	[self saveLocalDataPersistence:displayGridIDArray keyValue:DisplayHQTabID];
}

- (void)setDisplayGridImageArray:(NSMutableArray *)displayGridImageArray
{
	_displayGridImageArray = displayGridImageArray;
	[self saveLocalDataPersistence:displayGridImageArray keyValue:DisplayHQTabImage];
}

- (void)setDisplayGridTitleArray:(NSMutableArray *)displayGridTitleArray
{
	_displayGridTitleArray = displayGridTitleArray;
	[self saveLocalDataPersistence:displayGridTitleArray keyValue:DisplayHQTabTitle];
}

- (void)saveLocalDataPersistence:(NSMutableArray *)object keyValue:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)syncMutableArrayData:(NSMutableArray *)dataArray girdType:(MTSingleArrayType)arrayType
{
	NSMutableArray * array1 = [[NSMutableArray alloc]init];
	NSMutableArray * array2 = [[NSMutableArray alloc]init];
	NSMutableArray * array3 = [[NSMutableArray alloc]init];
	for (int i = 0; i < dataArray.count; i++) {
		CustomGridButton * grid = dataArray[i];
		[array1 addObject:grid.gridTitle];
		[array2 addObject:grid.gridImageString];
		[array3 addObject:[NSString stringWithFormat:@"%ld",(long)grid.gridId]];
	}
	if (arrayType == MTSingleDisplayArrayType) {
		self.displayGridIDArray = [[NSMutableArray alloc]initWithArray:array3];
		self.displayGridImageArray = [[NSMutableArray alloc]initWithArray:array2];
		self.displayGridTitleArray = [[NSMutableArray alloc]initWithArray:array1];
	}
	else if (arrayType == MTSingleOtherArrayType){
		self.otherGridIDArray = [[NSMutableArray alloc]initWithArray:array3];
		self.otherGridImageArray = [[NSMutableArray alloc]initWithArray:array2];
		self.otherGridTitleArray = [[NSMutableArray alloc]initWithArray:array1];
	}
}
@end
