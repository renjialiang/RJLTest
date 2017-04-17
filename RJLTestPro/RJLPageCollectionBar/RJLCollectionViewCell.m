//
//  RJLCollectionViewCell.m
//  RJLTestPro
//
//  Created by mini on 16/9/21.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLCollectionViewCell.h"

@implementation RJLCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _myWebView = [[UIWebView alloc] initWithFrame:frame];
    }
    return self;
}
@end
