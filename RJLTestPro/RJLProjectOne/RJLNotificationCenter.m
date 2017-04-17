//
//  RJLNotificationCenter.m
//  RJLTestPro
//
//  Created by mini on 16/8/23.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLNotificationCenter.h"
@interface NotificationCell()

@property(nonatomic, weak)id observer;
@property(nonatomic)SEL selector;
@property(nonatomic, retain)NSString* name;
@property(nonatomic, copy)nBlock block;

@end

@implementation NotificationCell

@end

@interface RJLNotificationCenter ()
@property(nonatomic)Boolean enableNotification;
@property(nonatomic, retain)NSMutableDictionary* notificationPool;

@end
@implementation RJLNotificationCenter
-(void)dealloc
{
	[self enableNotificationCenter:NO];
}

+(RJLNotificationCenter *)defaultCenter
{
	static RJLNotificationCenter* center = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		center = [[RJLNotificationCenter alloc] init];
		[center enableNotificationCenter:YES];
	});
	
	return center;
}
-(void)enableNotificationCenter:(BOOL)enable
{
	if (enable == _enableNotification) {
		return;
	}
	
	if (enable)
	{
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notifyReceive:) name:@"ControlNotify" object:nil];
	}
	else
	{
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notifyReceive:) name:@"ControlNotify" object:nil];
	}
	
	_enableNotification = enable;
}

- (void)notifyReceive:(NSNotification *)notification
{
	NSString *aName = [notification.userInfo objectForKey:@"notifyName"];
	if (aName) {
		NSMutableArray *nameObservers = [_notificationPool objectForKey:aName];
		if (nameObservers) {
			for (int idx = (int)([nameObservers count] - 1); idx >= 0; idx--) {
				NotificationCell *cell = [nameObservers objectAtIndex:idx];
				if (cell.observer) {
					if (cell.block) {
						cell.block(notification);
					}
					else if (cell.selector)
					{
						[cell.observer performSelectorOnMainThread:cell.selector withObject:notification waitUntilDone:NO];
					}
				}
				else
				{
					[nameObservers removeObjectAtIndex:idx];
				}
			}
		}
	}
}


-(NotificationCell*)registerCell:(id)observer name:(NSString *)aName object:(id)anObject
{
	if (_notificationPool == nil)
	{
		_notificationPool = [NSMutableDictionary new];
	}
	
	NSMutableArray* nameObservers = [_notificationPool objectForKey:aName];
	if (nameObservers == nil) {
		nameObservers = [NSMutableArray new];
		[_notificationPool setObject:nameObservers forKey:aName];
	}
	
	NotificationCell* cell = nil;
	for (int idx = (int)([nameObservers count] - 1); idx >= 0; --idx)
	{
		NotificationCell* find = [nameObservers objectAtIndex:idx];
		if (find.observer)
		{
			if (find.observer == observer)
			{
				cell = find;
				break;
			}
		}
		else
		{
			[nameObservers removeObjectAtIndex:idx];
			
		}
	}
	
	if (nil == cell)
	{
		cell = [NotificationCell new];
		cell.name = aName;
		cell.observer = observer;
		[nameObservers addObject:cell];
	}
	
	return cell;
}

-(void)addObserver:(id)observer block:(nBlock)block name:(NSString *)aName object:(id)anObject
{
	[self registerCell:observer name:aName object:anObject].block = block;
}


-(void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
	[self registerCell:observer name:aName object:anObject].selector = aSelector;
}


- (void)removeObserver:(id)observer
{
	NSArray* array = [_notificationPool allKeys];
	for (NSString* aName in array) {
		[self removeObserver:observer name:aName object:nil];
	}
}

-(void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
	if (aName)
	{
		NSMutableArray* nameObservers = [_notificationPool objectForKey:aName];
		for (int idx = (int)([nameObservers count] - 1); idx >= 0; --idx)
		{
			NotificationCell* find = [nameObservers objectAtIndex:idx];
			if (find.observer && find.observer != observer)
			{
			}
			else
			{
				[nameObservers removeObjectAtIndex:idx];
			}
		}
	}
}


- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;
{
	NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithDictionary:aUserInfo];
	[userInfo setObject:aName forKey:@"notifyName"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ControlNotify" object:nil userInfo:userInfo];
}

@end
