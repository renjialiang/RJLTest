//
//  FixTabView.h
//  RJLTestPro
//
//  Created by mini on 16/8/26.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomGridButton.h"
typedef void (^addFixGridItemBlock)(CustomGridButton *customItem);
@interface FixTabView : UIView  <CustomGridDelegate>
@property(nonatomic, strong) NSMutableArray *gridListArray;
@property(nonatomic, strong) NSMutableArray *fixGridTitleArray;
@property(nonatomic, strong) NSMutableArray *fixGridImageArray;
@property(nonatomic, strong) NSMutableArray *fixGridIDArray;
@property(nonatomic, copy) addFixGridItemBlock addFixItemBlock;
- (void)addFixGridItem:(CustomGridButton *)customItem;
@end
