//
//  RJLVoicePlayController.m
//  RJLTestPro
//
//  Created by mini on 16/8/5.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLVoicePlayController.h"
#import "VoicePlayer.h"
#import "RJLAudioPlayer.h"
@interface RJLVoicePlayController ()
@property (nonatomic, strong) AVURLAsset     *videoURLAsset;
//@property (nonatomic, strong) AVAsset        *videoAsset;
@property (nonatomic, strong) AVPlayer       *player;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
@property (nonatomic,strong) RJLAudioPlayer* audioPlayer;
@end

@implementation RJLVoicePlayController
-(void)viewWillAppear:(BOOL)animated
{
	
}


- (void)gotoplayvoice:(id)sender
{
	
	self.audioPlayer= [[RJLAudioPlayer alloc]init];
	[_audioPlayer tryPlayMusic];
	return;
	NSURL *url2 = nil;
	if (/* DISABLES CODE */ (NO)){
		url2 = [NSURL URLWithString:@"http://172.20.0.181/thsft/iFindService/CellPhone/i-strategy-road-show/download-audio/video/aa91c9a123d983d02a2d53692bc46f78.mp3"];
	}
	else {
		url2 = [NSURL URLWithString:@"http://10.0.16.33/ceshi.mp3"];
	}
	url2 = [NSURL URLWithString:@"http://10.0.16.33/363598977.aac"];
	NSString *str = [url2 absoluteString];
	NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
	NSString *filename = [[str componentsSeparatedByString:@"/"] lastObject];
	NSString *file = [[filename componentsSeparatedByString:@"."] firstObject];
	NSString *movePathTotal =  [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.acc",file]];
	NSString *movePathPart =  [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3.td",file]];
	
//	if ([[NSFileManager defaultManager] fileExistsAtPath:movePathTotal] && [[NSFileManager defaultManager] fileExistsAtPath:movePathPart]) {
//		
//	}
//	else {
//		[[NSFileManager defaultManager] removeItemAtPath:movePathPart error:nil];
//		[[NSFileManager defaultManager] removeItemAtPath:movePathTotal error:nil];
//	}
	
	[[VoicePlayer sharedInstance] cancelVoiceDownload];
	if ([[NSFileManager defaultManager] fileExistsAtPath:movePathTotal]) {
		NSURL *localURL = [NSURL fileURLWithPath:movePathTotal];
		[[VoicePlayer sharedInstance] playWithUrl:localURL showView:self.view startOffset:0];
	}
	else if ([[NSFileManager defaultManager] fileExistsAtPath:movePathPart]) {
		NSData *data = [NSData dataWithContentsOfFile:movePathPart];
		[[VoicePlayer sharedInstance] playWithUrl:url2 showView:self.view startOffset:data.length];
	}
	else {
		[[VoicePlayer sharedInstance] playWithUrl:url2 showView:self.view startOffset:0];
	}

}


@end
