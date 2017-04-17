//
//  RJLAudioPlayer.m
//  RJLTestPro
//
//  Created by mini on 16/8/31.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLAudioPlayer.h"

@implementation RJLAudioPlayer
#pragma mark - AVAudioPlayerDelegate methods
- (instancetype)init
{
	self = [super init];
	if (self) {
		[self configureAudioSession];
		[self configureAudioPlayer];
	}
	return self;
}
- (void) configureAudioSession {
	// Implicit initialization of audio session
	self.audioSession = [AVAudioSession sharedInstance];
	
	// Set category of audio session
	// See handy chart on pg. 46 of the Audio Session Programming Guide for what the categories mean
	// Not absolutely required in this example, but good to get into the habit of doing
	// See pg. 10 of Audio Session Programming Guide for "Why a Default Session Usually Isn't What You Want"
	
	NSError *setCategoryError = nil;
	if ([self.audioSession isOtherAudioPlaying]) { // mix sound effects with music already playing
		[self.audioSession setCategory:AVAudioSessionCategorySoloAmbient error:&setCategoryError];
//		self.backgroundMusicPlaying = NO;
	} else {
		[self.audioSession setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
	}
	if (setCategoryError) {
		NSLog(@"Error setting category! %ld", (long)[setCategoryError code]);
	}
}

- (void)configureAudioPlayer {
	// Create audio player with background music
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"363598977" ofType:@"acc"];
	NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
	self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:nil];
	self.backgroundMusicPlayer.delegate = self;  // We need this so we can restart after interruptions
	self.backgroundMusicPlayer.numberOfLoops = -1;	// Negative number means loop forever
}
- (void)tryPlayMusic {
	// If background music or other music is already playing, nothing more to do here
//	if (self.backgroundMusicPlaying || [self.audioSession isOtherAudioPlaying]) {
//		return;
//	}
	
	// Play background music if no other music is playing and we aren't playing already
	//Note: prepareToPlay preloads the music file and can help avoid latency. If you don't
	//call it, then it is called anyway implicitly as a result of [self.backgroundMusicPlayer play];
	//It can be worthwhile to call prepareToPlay as soon as possible so as to avoid needless
	//delay when playing a sound later on.
	[self.backgroundMusicPlayer prepareToPlay];
	[self.backgroundMusicPlayer play];
//	self.backgroundMusicPlaying = YES;
}

- (void) audioPlayerBeginInterruption: (AVAudioPlayer *) player {

}

- (void) audioPlayerEndInterruption: (AVAudioPlayer *) player withOptions:(NSUInteger) flags{
	//Since this method is only called if music was previously interrupted
	//you know that the music has stopped playing and can now be resumed.
	[self tryPlayMusic];
//	self.backgroundMusicInterrupted = NO;
}
@end
