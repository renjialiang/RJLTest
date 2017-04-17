//
//  FixTabView.m
//  RJLTestPro
//
//  Created by mini on 16/8/26.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "FixTabView.h"
#import "MTSingletonManager.h"
@implementation FixTabView
- (void)dealloc
{
	NSLog(@"dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initMySelf];
	}
	return self;
}

- (void)initMySelf
{
	self.gridListArray = [[NSMutableArray alloc] initWithCapacity:10];
	self.fixGridTitleArray = [MTSingletonManager shareInstance].otherGridTitleArray;
	self.fixGridImageArray = [MTSingletonManager shareInstance].otherGridImageArray;
	self.fixGridIDArray = [MTSingletonManager shareInstance].otherGridIDArray;
	[self.gridListArray removeAllObjects];
	for (NSInteger index = 0; index < [_fixGridTitleArray count]; index++)
	{
		NSString *gridTitle = _fixGridTitleArray[index];
		NSString *gridImage = _fixGridImageArray[index];
		NSInteger gridID = [self.fixGridIDArray[index] integerValue];
		CustomGridButton *gridItem = [[CustomGridButton alloc] initWithFrame:CGRectZero title:gridTitle normalImage:[UIImage imageNamed:@"app_item_bg"] highlightedImage:[UIImage imageNamed:@"app_item_bg"] gridId:gridID atIndex:index isAddDelete:YES deleteIcon:[UIImage imageNamed:@"app_item_plus"]  withIconImage:gridImage];
		gridItem.delegate = self;
		gridItem.gridTitle = gridTitle;
		gridItem.gridImageString = gridImage;
		gridItem.gridId = gridID;
		[self addSubview:gridItem];
		[self.gridListArray addObject:gridItem];
	}
	//for test print out
	for (NSInteger i = 0; i < _gridListArray.count; i++) {
		CustomGridButton *gridItem = _gridListArray[i];
		gridItem.gridCenterPoint = gridItem.center;
	}
	//更新页面
	[self getNewData];
}

#pragma mark --- 更新页面
-(void)getNewData
{
	NSInteger gridHeight;
	if (self.gridListArray.count % PerRowCustomGridCount == 0) {
		NSUInteger row = self.gridListArray.count / PerRowCustomGridCount;
		gridHeight = CustomGridHeight * row + PaddingY * (row + 1);
	}
	else{
		NSUInteger row = self.gridListArray.count / PerRowCustomGridCount;
		gridHeight = CustomGridHeight * (row + 1) + PaddingY * (row + 2);
	}
	CGRect frameRect = self.frame;
	if (gridHeight < CustomGridHeight) {
		gridHeight = CustomGridHeight + PaddingY * 2;
	}
	frameRect.size.height = gridHeight;
	self.frame = frameRect;
}

- (void)addFixGridItem:(CustomGridButton *)customItem
{
	[customItem changeAddCustomFrame:[_gridListArray count]];
	customItem.delegate = self;
	customItem.gridIndex = [_gridListArray count];
	UIButton *removeBtn = (UIButton *)[customItem viewWithTag:customItem.gridId];
	removeBtn.hidden = YES;
	[_gridListArray addObject:customItem];
	[_fixGridTitleArray addObject:customItem.gridTitle];
	[_fixGridImageArray addObject:customItem.gridImageString];
	[_fixGridIDArray addObject:[NSNumber numberWithInteger:customItem.gridId]];
	[self addSubview:customItem];
	customItem.delegate = self;
	//更新页面
	[self getNewData];
	[[MTSingletonManager shareInstance] syncMutableArrayData:_gridListArray girdType:MTSingleOtherArrayType];
}

#pragma mark CustomGridDelegate
- (void)gridItemDidClicked:(CustomGridButton *)clickItem
{
	[self removeOutOfRangeCustomButton:clickItem];
}

- (void)removeOutOfRangeCustomButton:(CustomGridButton *)item
{
	NSInteger index = [self.gridListArray indexOfObject:item];
	if ([_gridListArray count] > 1) {
		for (NSInteger j = [self.gridListArray count] - 1; j > index; j--) {
			CustomGridButton *customButton = [_gridListArray objectAtIndex:j];
			CustomGridButton *customPlusButton = [_gridListArray objectAtIndex:j - 1];
			customButton.gridIndex = customPlusButton.gridIndex;
			customButton.center = customPlusButton.gridCenterPoint;
		}
	}
	[item removeFromSuperview];
	[self.gridListArray removeObject:item];
	//更新所有格子的中心点坐标信息
	for (NSInteger i = 0; i < _gridListArray.count; i++)
	{
		CustomGridButton *gridItem = _gridListArray[i];
		gridItem.gridCenterPoint = gridItem.center;
	}
	for (NSInteger i = 0; i < _gridListArray.count; i++)
	{
		CustomGridButton *customButton = [_gridListArray objectAtIndex:i];
		[UIView animateWithDuration:0.5 animations:^{
			customButton.center = customButton.gridCenterPoint;
		}];
	}
	[self getNewData];
	[[MTSingletonManager shareInstance] syncMutableArrayData:_gridListArray girdType:MTSingleOtherArrayType];
	if (self.addFixItemBlock) {
		self.addFixItemBlock(item);
	}
}

@end
