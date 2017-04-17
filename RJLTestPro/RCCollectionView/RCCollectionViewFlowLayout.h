//
//  RCCollectionViewFlowLayout.h
//  RJLTestPro
//
//  Created by mini on 2016/12/14.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RCCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) CGFloat contentHeght; //纪录布局需要的contentSize的高度
@property (nonatomic, strong) NSMutableArray *columnHeights; //纪录各列的当前布局高度
@property (nonatomic, strong) NSMutableArray *attrsArray;
@property (nonatomic) CGFloat columnCount;	//每行的个数
@property (nonatomic) CGFloat columnMargin;	//item之间的间距
@property (nonatomic) CGFloat rowMargin; //多行之间的间距
@property (nonatomic) UIEdgeInsets edgeInsets; //
@end
