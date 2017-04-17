//
//  CoreTextDisplayView.h
//  RJLTestPro
//
//  Created by mini on 16/6/14.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"

extern NSString *const CTDisplayViewImagePressedNotification;
extern NSString *const CTDisplayViewLinkPressedNotification;
@interface CoreTextDisplayView : UIView
@property (nonatomic, strong) CoreTextData * data;
@end
