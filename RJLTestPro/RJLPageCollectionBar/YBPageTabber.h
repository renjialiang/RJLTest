//
//  HQPageTabber.h
//  AMHexin
//
//  Created by hexin on 12/31/13.
//
//

#import "YBPageRoundScroller.h"
#import "CompView.h"
#import "YBScrollTabHeadView.h"
#import "PageGrouper.h"

#define  SELECTED_BAR_HEIGHT    12

#define TAB_HEAD_VIEW_HEIGHT    44
@class YBPageTabber;
@protocol YBPageTabberDelegate <NSObject>
- (void)pageTabber:(YBPageTabber *)pageTabber addButtonClick:(UIButton *)button;
@end
@interface YBPageTabber : CompView <YBPageRoundScrollerDelegate, YBScrollTabHeadViewDelegate, PageGroupProtocol>

@property (nonatomic, retain) YBScrollTabHeadView *headView;
@property (nonatomic, retain) NSArray   *pageViewArray;
@property (nonatomic) NSInteger selectIndex;
@property (nonatomic, retain) YBPageRoundScroller* pageScroller;
@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *mark;
@property (nonatomic, retain) NSArray   *titleArray;
@property(nonatomic, weak) id<YBPageTabberDelegate> delegate;
@property(nonatomic, strong) UIButton *addButton;
@property(nonatomic, copy) NSString *toString;
@property(nonatomic, assign) BOOL noOpenAddButton;

@property (readonly) NSMutableArray* aryPages;
@property (weak) PageGrouper* pageGrouper;
//设置焦点 page,并不通知页面被显示
- (BOOL)setFocusPageWithId:(int)nPageId;
- (BOOL)setFocusPageWithIndex:(int)index;
    
- (PageView*)getCurFocusPage;
- (void)setPageGroupToPageView:(PageGrouper*)pageGroup;

- (NSArray *)pageViewTitles;
- (id)initWithFrame:(CGRect)frame andInfo:(NSArray*)ary;
+ (YBPageTabber *)getYBPageTabber:(UIView *)view;
@end
