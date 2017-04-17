//
//  CustomGridButton.h
//  RJLTestPro
//
//  Created by mini on 16/8/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define CustomGridHeight 50
#define PerRowCustomGridCount 5
#define PaddingX 10
#define PaddingY 10
#define CustomGridWidth ((ScreenWidth - (PerRowCustomGridCount + 1) * PaddingX)/ PerRowCustomGridCount)


@protocol CustomGridDelegate;

@interface CustomGridButton : UIButton
@property(nonatomic, strong) NSString *gridTitle;
@property(nonatomic, strong) NSString *gridImageString;
@property(nonatomic) NSInteger gridId;
@property(nonatomic) BOOL      isChecked;
@property(nonatomic) BOOL      isMove;
@property(nonatomic) NSInteger gridIndex;
@property(nonatomic) CGPoint   gridCenterPoint;
@property(nonatomic, weak) id <CustomGridDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
						title:(NSString *)title
				  normalImage:(UIImage *)normalImage
			 highlightedImage:(UIImage *)highlightedImage
					   gridId:(NSInteger)gridId
					  atIndex:(NSInteger)index
				  isAddDelete:(BOOL)isAddDelete
				   deleteIcon:(UIImage *)deleteIcon
				withIconImage:(NSString *)imageString;

+ (NSInteger)indexOfPoint:(CGPoint)point
			   withButton:(UIButton *)btn
				gridArray:(NSMutableArray *)gridListArray;
- (void)changeAddCustomFrame:(NSInteger)index;
@end
@protocol CustomGridDelegate <NSObject>
@optional
- (void)pressGestureStateBegan:(UIPanGestureRecognizer *)tapPressGesture withGridItem:(CustomGridButton *)gridItem;

- (void)pressGestureStateChangedWithPoint:(CGPoint) gridPoint gridItem:(CustomGridButton *)gridItem;

- (void)pressGestureStateEnded:(CustomGridButton *)gridItem;

- (void)gridItemDidClicked:(CustomGridButton *)clickItem;

- (void)gridItemDidDeleteClicked:(UIButton *)deleteButton;
@end