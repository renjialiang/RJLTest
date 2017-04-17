//
//  YBPageRoundScroller.h
//  AMHexin
//
//  Created by hexin on 1/6/14.
//
//

#import <UIKit/UIKit.h>
@protocol YBPageRoundScrollerDelegate;
@interface YBPageRoundScroller : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) id<YBPageRoundScrollerDelegate> roundDelegate;
@property (nonatomic, retain, readonly) NSArray *viewArray;
@property (nonatomic) int focusIndex;
- (id)initWithViews:(NSArray *)viewArray andLayout:(UICollectionViewFlowLayout *)layout;
@end


@protocol YBPageRoundScrollerDelegate <NSObject>
- (void)didScroll:(YBPageRoundScroller *)scroller fromIndex:(int)from toIndex:(int)to;
@end
