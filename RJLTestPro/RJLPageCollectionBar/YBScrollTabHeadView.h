//
//  YBScrollTabHeadView.h
//  AMHexin
//
//  Created by hexin on 1/6/14.
//
//

#import <UIKit/UIKit.h>
#import "YBPageRoundScroller.h"
@protocol YBScrollTabHeadViewDelegate;
@interface YBScrollTabHeadView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, weak) id<YBScrollTabHeadViewDelegate> headViewdelegate;
@property (nonatomic, retain) NSArray *titles;
@property (nonatomic) NSInteger pageId;
@property(nonatomic, assign) BOOL noOpenAddButton;
- (id)initWithTitles:(NSArray *)titles noOpenAddButton:(BOOL)noOpenAddButton;
- (id)initWithTitles:(NSArray *)titles;
- (void)setTitleHighlightAtIndex:(int)index animate:(BOOL)isAnim;
- (int)getSelectdIndex;
- (void)gotoSection:(int)index;
- (void)gotoTitleWithIndex:(NSInteger )index;
-(void)setHighlightBottomColor:(UIColor *)highlightBottomColor;
-(void)setButtonNormalColor:(UIColor *)buttonNormalColor andSelectColor:(UIColor *)buttonSelectedColor;
@end

@protocol YBScrollTabHeadViewDelegate <NSObject>

- (void)scrollTabHeadView:(YBScrollTabHeadView *)headView clickedAtIndex:(int)index;

@end
