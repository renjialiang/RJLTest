//
//  ifmLinearLayoutScrollView.m
//  framework
//
//  Created by wxzy on 15/12/10.
//  Copyright (c) 2015年 wxzy. All rights reserved.
//

#import "ifmLinearLayoutScrollView.h"
#import "UIImageViewEx.h"

#define observer_keypath @"frame"
#define imageView_tag 9999

@interface ifmLinearLayoutScrollView ()
{
    int  _imageviewCount;
}
@end

@implementation ifmLinearLayoutScrollView

-(void)dealloc
{
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _imageviewCount = 0;
//        self.autoresizesSubviews = NO;
        [self performSelectorOnMainThread:@selector(relayoutSubviews:) withObject:self waitUntilDone:NO];
    }
    return self;
}

-(void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2
{
    [super exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
    [self relayoutSubviews:nil];
}

-(void)bringSubviewToFront:(UIView *)view
{
    [super bringSubviewToFront:view];
    [self relayoutSubviews:nil];
}

-(void)sendSubviewToBack:(UIView *)view
{
    [super sendSubviewToBack:view];
    [self relayoutSubviews:nil];
}
-(void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    if ([subview isKindOfClass:[UIImageView class]]) {
        if (![subview isMemberOfClass:[UIImageViewEx class]]) {
            subview.tag = imageView_tag;
            return;
        }
    }
    [self registerFrameObeserve:subview];
    [self relayoutSubviews:nil];
}

-(void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];
    if (subview.tag != imageView_tag) {
       _removedView = subview;
       [self unregisterFrameObeserve:subview];
    }
    [self relayoutSubviews:subview];
}

-(void)registerFrameObeserve:(UIView*)view
{
    [view addObserver:self forKeyPath:observer_keypath options:NSKeyValueObservingOptionNew context:nil];
}

-(void)unregisterFrameObeserve:(UIView*)view
{
    [view removeObserver:self forKeyPath:observer_keypath];
}

-(void)relayoutSubviews:(UIView*)removeView;
{
    
    CGFloat origin = 0.0;
    for (int i = 0; i < [self.subviews count]; ++i) {
        UIView* view = [self.subviews objectAtIndex:i];
        if (removeView == view) {
            continue;
        }
        if (_removedView == view) {
            continue;
        }
        if (view.tag == imageView_tag) {
            continue;
        }
            [self unregisterFrameObeserve:view];
        
        if (_orientationHorizontal) {
            view.frame = CGRectMake(origin, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            origin += view.frame.size.width;
        }
        else
        {
            view.frame = CGRectMake(view.frame.origin.x, origin, view.frame.size.width, view.frame.size.height);
            origin += view.frame.size.height;
        }
           [self registerFrameObeserve:view];
    }
    
    if (_orientationHorizontal) {
        if (origin > self.bounds.size.width) {
            self.contentSize = CGSizeMake(origin, self.contentSize.height);
        }
        else
        {
            self.contentSize = CGSizeMake(0.0, self.contentSize.height);
        }
    }
    else
    {
//        CGRect rc = self.bounds;
        if (origin > self.bounds.size.height) {
            self.contentSize = CGSizeMake(self.contentSize.width, origin);
        }
        else
        {
            self.contentSize = CGSizeMake(self.contentSize.width, 0.0);
        }
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:observer_keypath]) {
        for (UIView* subView in self.subviews) {
            if (subView == object) {
                [self relayoutSubviews:nil];
                break;
            }
        }
    }
}

@end
