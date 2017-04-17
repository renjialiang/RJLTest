//
//  NewPageTabber.m
//  RJLTestPro
//
//  Created by mini on 2016/10/8.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "NewPageTabber.h"
@interface NewPageTabber ()
@property (nonatomic, strong) NSArray *pageInfoArray;
@end
@implementation NewPageTabber
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame infoArray:(NSArray *)params
{
    self = [self initWithFrame:frame];
    if (self)
    {
        [self initMyViewFrame];
        [self initMyViewData:params];
    }
    return self;
}

- (void)initMyViewFrame
{
    if (self.topTitleScrollView)
    {
        [self.topTitleScrollView removeFromSuperview];
        self.topTitleScrollView = nil;
    }
    if (self.bottomPageScrollView)
    {
        [self.bottomPageScrollView removeFromSuperview];
        self.bottomPageScrollView = nil;
    }

    CGRect selfFrame = self.bounds;
    selfFrame.size.height = TITLEVIEWHEIGHT;
    _topTitleScrollView = [[RJLWheelTitleView alloc] initWithFrame:selfFrame];
    [_topTitleScrollView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_topTitleScrollView];
    selfFrame.origin.y = TITLEVIEWHEIGHT;
    selfFrame.size.height = self.bounds.size.height - TITLEVIEWHEIGHT;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(selfFrame.size.width, selfFrame.size.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _bottomPageScrollView = [[RJLWheelPageView alloc] initWithFrame:selfFrame collectionViewLayout:layout];
    [_bottomPageScrollView setBackgroundColor:[UIColor redColor]];
    [self addSubview:_bottomPageScrollView];
}

- (void)initMyViewData:(NSArray *)params
{
    if (params && params.count > 0)
    {
        NSMutableArray *titlesArray = [NSMutableArray array];
        NSMutableArray *pageIdsArray = [NSMutableArray array];
        NSMutableArray *pageTypesArray = [NSMutableArray array];
        for (NSInteger index = 0; index < params.count; index++)
        {
            NSDictionary *dicInfo = [params objectAtIndex:index];
            if (!dicInfo || ![dicInfo isKindOfClass:[NSDictionary class]])
            {
                continue;
            }
            if ([dicInfo objectForKey:PageTitle])
            {
                [titlesArray addObject:[dicInfo objectForKey:PageTitle]];
            }
            if ([dicInfo objectForKey:PageId])
            {
                [pageIdsArray addObject:[dicInfo objectForKey:PageId]];
            }
            if ([dicInfo objectForKey:ViewType])
            {
                [pageTypesArray addObject:[dicInfo objectForKey:ViewType]];
            }
        }
    }
}
@end
