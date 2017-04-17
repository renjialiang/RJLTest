//
//  MoveTabView.h
//  RJLTestPro
//
//  Created by mini on 16/8/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomGridButton.h"
typedef void (^addGridItemBlock)(CustomGridButton *customItem);
#define RetainBaseItemCount 3
@interface MoveTabView : UIView
@property(nonatomic, strong) NSMutableArray *gridListArray;
@property(nonatomic, strong) NSMutableArray *displayGridTitleArray;
@property(nonatomic, strong) NSMutableArray *displayGridImageArray;
@property(nonatomic, strong) NSMutableArray *displayGridIDArray;
@property(nonatomic, copy) addGridItemBlock addBlock;
- (void)refreshPageToEdit;
- (void)closeEditState;
- (void)addGridItem:(CustomGridButton *)customItem;
@end
