//
//  MagnifiterView.h
//  RJLTestPro
//
//  Created by mini on 16/6/14.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagnifiterView : UIView
@property (nonatomic, weak) UIView *viewToMagnify;
@property (nonatomic) CGPoint	touchPoint;
@end
