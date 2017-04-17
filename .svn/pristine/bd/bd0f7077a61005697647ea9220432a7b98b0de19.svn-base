//
//  RJLAdvertisementSrollView.h
//  RJLTestPro
//
//  Created by mini on 16/5/17.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define InputSubViewType		@"inputSubViewType"
#define UIViewScrollStrategy	@"viewScrollStrategy"
#define SelfAutoLayoutWithImage	@"viewAutoSetHeightWithImage"

typedef NS_ENUM(NSInteger, SubType)
{
	type_urlimage = 0,//传入的数组为图片下载网址
	type_localimage = 1,//传入的数组为UIimage对象
	type_customview = 2,//传入的数组为VIview
	type_imageName = 3//传入的数组为本地图片的名称
};

typedef NS_ENUM(NSInteger, AutoScrollStrategy)
{
	leftToright = 0,
	rightToleft = 1,
	topTobottom = 2,
	bottomTotop = 3,
};

@protocol RJLAdvertisementSrollViewDelegate <NSObject>

- (void)didSelectedViewWithData:(id)data;

@end

@interface RJLAdvertisementSrollView : UIView
@property (nonatomic, weak) id <RJLAdvertisementSrollViewDelegate> svDelegate;

- (instancetype)initWithFrame:(CGRect)frame timeInterval:(NSTimeInterval)timeInterVal subViewArray:(NSArray *)viewArray dataArray:(NSArray *)dataArray exParam:(NSDictionary *)dicParam;
- (void)initControl:(CGRect)frame timeInterval:(NSTimeInterval)timeInterVal subViewArray:(NSArray *)viewArray dataArray:(NSArray *)dataArray exParam:(NSDictionary *)dicParam;
@end
