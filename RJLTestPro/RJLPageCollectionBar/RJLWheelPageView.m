//
//  RJLWheelPageView.m
//  RJLTestPro
//
//  Created by mini on 16/9/21.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLCollectionViewCell.h"
#import "RJLWheelPageView.h"
@interface RJLWheelPageView ()
@property (nonatomic, strong) NSMutableArray *viewArray;
@end

@implementation RJLWheelPageView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [UIView new];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.clipsToBounds = NO;
        self.canCancelContentTouches = NO;
        self.multipleTouchEnabled = NO;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[RJLCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

- (void)setPageViewArray:(NSArray *)pageArray
{
    if (self.viewArray == nil)
    {
        self.viewArray = [[NSMutableArray alloc] initWithArray:pageArray];
    }
    else
    {
        [self.viewArray removeAllObjects];
        [self.viewArray addObjectsFromArray:pageArray];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RJLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_viewArray objectAtIndex:indexPath.row]]]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
