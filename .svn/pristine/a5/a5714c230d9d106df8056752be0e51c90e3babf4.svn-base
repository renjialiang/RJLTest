//
//  YBPageRoundScroller.m
//  AMHexin
//
//  Created by hexin on 1/6/14.
//
//

#import "YBPageRoundScroller.h"
@interface YBPageRoundScroller ()

@end

@implementation YBPageRoundScroller

- (id)initWithViews:(NSArray *)viewArray andLayout:(UICollectionViewFlowLayout *)layout
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self)
    {
        _viewArray = viewArray;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell2"];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.width, self.height);
}

- (void)dealloc
{
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _viewArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UICollectionViewCell alloc] init];
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    UIView *view = [_viewArray objectAtIndex:indexPath.row];
    view.frame = CGRectMake(0, 0, self.width, self.height);
    [cell.contentView addSubview:view];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    int index = (int)(offsetX / scrollView.width + 0.5);
    if ([_roundDelegate respondsToSelector:@selector(didScroll:fromIndex:toIndex:)] && _focusIndex != index)
    {
        [_roundDelegate didScroll:self fromIndex:_focusIndex toIndex:index];
    }
    _focusIndex = index;
}
@end
