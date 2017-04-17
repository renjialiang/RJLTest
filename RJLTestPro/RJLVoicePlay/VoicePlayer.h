//
//  VoicePlayer.h
//  RJLTestPro
//
//  Created by mini on 16/8/11.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
FOUNDATION_EXPORT NSString *const kPlayerProgressChangedNotification;
FOUNDATION_EXPORT NSString *const kPlayerLoadProgressChangedNotification;
@interface VoicePlayer : NSObject
+ (instancetype)sharedInstance;

- (void)playWithUrl:(NSURL *)url showView:(UIView *)showView startOffset:(NSUInteger)offset;
- (void)cancelVoiceDownload;
- (void) configureAudioSession;
@end
