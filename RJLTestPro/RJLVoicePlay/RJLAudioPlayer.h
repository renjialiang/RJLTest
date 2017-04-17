//
//  RJLAudioPlayer.h
//  RJLTestPro
//
//  Created by mini on 16/8/31.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@interface RJLAudioPlayer : NSObject <AVAudioPlayerDelegate>
@property (strong, nonatomic) AVAudioSession *audioSession;
@property (strong, nonatomic) AVAudioPlayer *backgroundMusicPlayer;
@property (assign) BOOL backgroundMusicPlaying;
@property (assign) BOOL backgroundMusicInterrupted;
@property (assign) SystemSoundID pewPewSound;
- (void)tryPlayMusic;
- (instancetype)init;
@end
