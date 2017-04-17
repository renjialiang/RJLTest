//
//  RCCollectionViewFlowLayout.m
//  RJLTestPro
//
//  Created by mini on 2016/12/14.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RCCollectionViewFlowLayout.h"

@implementation RCCollectionViewFlowLayout
- (void)prepareLayout
{
	[super prepareLayout];
	self.contentHeght = 0;
	[self.columnHeights removeAllObjects];
	for (NSInteger i = 0; i < self.columnCount ; i++) {
		[self.columnHeights addObject:@(self.edgeInsets.top)];
	}
	
	[self.attrsArray removeAllObjects];
	NSInteger count = [self.collectionView numberOfItemsInSection:0];
	for (NSInteger index = 0; index < count; index ++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
		UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
		[self.attrsArray addObject:attrs];
	}
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewLayoutAttributes *attrs = [super layoutAttributesForItemAtIndexPath:indexPath];
	CGFloat collectionViewW = self.collectionView.frame.size.width;
	CGFloat width = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
	CGFloat height = arc4random() % 50 + 50;
	
	NSInteger destColumn = 0;
	CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
	for (NSInteger index = 1; index < self.columnCount; index++)
	{
		CGFloat columnHeight = [self.columnHeights[index] doubleValue];
		if (minColumnHeight > columnHeight) {
			minColumnHeight = columnHeight;
			destColumn = index;
			break;
		}
	}
	
	CGFloat x = self.edgeInsets.left + destColumn * (width + self.columnMargin);
	CGFloat y = minColumnHeight;
	if (y != self.edgeInsets.top)
	{
		y += self.rowMargin;
	}
	attrs.frame = CGRectMake(x, y, width, height);
	self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
	CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
	if (self.contentHeght < columnHeight)
	{
		self.contentHeght = columnHeight;
	}
	return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
	NSMutableArray *array = [NSMutableArray array];
	for (UICollectionViewLayoutAttributes *attrs in _attrsArray) {
		if (CGRectIntersectsRect(attrs.frame, rect)) {
			[array addObject:attrs];
		}
	}
	return array;
}

- (CGSize)collectionViewContentSize
{
	return CGSizeMake(CGRectGetWidth(self.collectionView.frame), self.contentHeght + self.edgeInsets.bottom);
}
@end
