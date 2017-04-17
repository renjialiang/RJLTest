//
//  NewPageTabber.h
//  RJLTestPro
//
//  Created by mini on 2016/10/8.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLWheelPageView.h"
#import "RJLWheelTitleView.h"
#import <UIKit/UIKit.h>
static const NSString *PageTitle = @"titles";
static const NSString *PageId = @"pageids";
static const NSString *ViewType = @"types";

typedef NS_ENUM(NSInteger, PageViewType) {
    PageViewNoneType = 0,
    PageViewWebViewType = 1,
};

@interface NewPageTabber : UIView
@property (nonatomic, strong) RJLWheelTitleView *topTitleScrollView;
@property (nonatomic, strong) RJLWheelPageView *bottomPageScrollView;
- (instancetype)initWithFrame:(CGRect)frame infoArray:(NSArray *)params;
@end
