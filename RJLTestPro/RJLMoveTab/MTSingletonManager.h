//
//  MTSingletonManager.h
//  RJLTestPro
//
//  Created by mini on 16/8/24.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define OtherHQTabID @"otherhqtabid"
#define OtherHQTabTitle @"otherhqtabtitle"
#define OtherHQTabImage @"otherhqtabimage"
#define DisplayHQTabID @"displayhqtabid"
#define DisplayHQTabTitle @"displayhqtabtitle"
#define DisplayHQTabImage @"displayhqtabimage"

typedef NS_ENUM(NSUInteger, MTSingleArrayType){
	MTSingleDisplayArrayType = 0,
	MTSingleOtherArrayType = 1
};
@interface MTSingletonManager : NSObject
// 主页 按钮 数组
@property (strong,nonatomic) NSMutableArray * displayGridTitleArray; // 标题
@property (strong,nonatomic) NSMutableArray * displayGridImageArray; // 图片
@property (strong,nonatomic) NSMutableArray * displayGridIDArray;  //button的ID

// 主页 更多 按钮 数组
@property (strong,nonatomic) NSMutableArray * otherGridTitleArray; // 标题
@property (strong,nonatomic) NSMutableArray * otherGridImageArray; // 图片
@property (strong,nonatomic) NSMutableArray * otherGridIDArray;  //button的ID
+ (MTSingletonManager *)shareInstance;
- (void)syncMutableArrayData:(NSMutableArray *)dataArray girdType:(MTSingleArrayType)arrayType;
@end
