//
//  RJLNotificationCenter.h
//  RJLTestPro
//
//  Created by mini on 16/8/23.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^nBlock) (NSNotification *notification);
@interface NotificationCell : NSObject

@end
@interface RJLNotificationCenter : NSObject
- (void)enableNotificationCenter:(BOOL)enable;
- (void)addObserver:(NSObject *)observer block:(nBlock)block name:(NSString *)aName object:(id)anObject;
- (void)addObserver:(NSObject *)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;
- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;
+ (RJLNotificationCenter*)defaultCenter;
@end
