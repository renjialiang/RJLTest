//
//  RJLTableView.m
//  RJLTestPro
//
//  Created by mini on 16/9/20.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLTableView.h"

@implementation RJLTableView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Remove touch delay (since iOS 8)
    UIView *wrapView = self.subviews.firstObject;
    // UITableViewWrapperView
    if (wrapView &&
        [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"])
    {
        for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers)
        {
            // UIScrollViewDelayedTouchesBeganGestureRecognizer
            if ([NSStringFromClass(gesture.class)
                    containsString:@"DelayedTouchesBegan"])
            {
                gesture.enabled = NO;
                break;
            }
        }
    }

    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIControl class]])
    {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}
@end
