//
//  VoicePlayer.m
//  RJLTestPro
//
//  Created by mini on 16/8/11.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "VoicePlayer.h"
#import "VoicePlayerView.h"
#import "TBVideoRequestTask.h"
NSString *const kPlayerProgressChangedNotification = @"PlayerProgressChangedNotification";
NSString *const kPlayerLoadProgressChangedNotification = @"PlayerLoadProgressChangedNotification";
@interface VoicePlayer () <AVAssetResourceLoaderDelegate, TBVideoRequestTaskDelegate, VoicePlayerOptionDelegate>
@property (nonatomic, strong) AVURLAsset     *videoURLAsset;
@property (nonatomic, strong) AVAsset        *videoAsset;
@property (nonatomic, strong) AVPlayer       *player;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
@property (nonatomic, strong) NSObject       *playbackTimeObserver;
@property (nonatomic, strong) VoicePlayerView *displayView;
@property (nonatomic) CGFloat       loadedProgress;//缓冲进度
@property (nonatomic) Float64		duration;
@property (nonatomic, strong) TBVideoRequestTask *downLoadTask;
@end

@implementation VoicePlayer
+ (instancetype)sharedInstance {
	static dispatch_once_t onceToken;
	static id _sInstance;
	dispatch_once(&onceToken, ^{
		_sInstance = [[self alloc] init];
	});
	
	return _sInstance;
}
- (instancetype)init
{
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)playWithUrl:(NSURL *)url showView:(UIView *)showView startOffset:(NSUInteger)offset
{
	
	[self.player pause];
	[self releasePlayer];
	if (self.displayView) {
		[self.displayView removeFromSuperview];
		self.displayView = nil;
	}
	self.displayView = [[VoicePlayerView alloc] initWithFrame:CGRectMake(15, 100, [UIScreen mainScreen].bounds.size.width - 30, 40)];
	[showView addSubview:self.displayView];
	self.displayView.delegate = self;
	self.loadedProgress = 0;
	self.duration = 0;
	NSString *str = [url absoluteString];
	if (![str hasPrefix:@"http"])
	{
		self.videoAsset = [AVAsset assetWithURL:url];
		self.currentPlayerItem = [AVPlayerItem playerItemWithAsset:_videoAsset];
		if (!self.player) {
			self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
		}
		else {
			[self.player replaceCurrentItemWithPlayerItem:self.currentPlayerItem];
		}
	}
	else
	{
		self.downLoadTask = [[TBVideoRequestTask alloc]initWithFileName:[self getVoiceName:str]];
		self.downLoadTask.delegate = self;
		[self.downLoadTask setUrl:url offset:offset];
		self.videoURLAsset = [AVURLAsset URLAssetWithURL:url options:nil];
		[_videoURLAsset.resourceLoader setDelegate:self queue:dispatch_get_main_queue()];
//		_videoURLAsset
		self.currentPlayerItem = [AVPlayerItem playerItemWithAsset:_videoURLAsset];
		if (!self.player) {
			self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
		}
		else {
			[self.player replaceCurrentItemWithPlayerItem:self.currentPlayerItem];
		}
	}
	[self.currentPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
	[self.currentPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
	[self.currentPlayerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
	[self.currentPlayerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
	

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.currentPlayerItem];
	[[NSNotificationCenter defaultCenter] postNotificationName:kPlayerProgressChangedNotification object:nil];
}


#pragma mark - 获取文件名字
- (NSString *)getVoiceName:(NSString *)url
{
	NSString *file = [[url componentsSeparatedByString:@"/"] lastObject];
	NSString *fileName = [[file componentsSeparatedByString:@"."] firstObject];
	return fileName;
}

#pragma mark - 清除页面通知
- (void)releasePlayer
{
	if (!self.currentPlayerItem) {
		return;
	}
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self.currentPlayerItem removeObserver:self forKeyPath:@"status"];
	[self.currentPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
	[self.currentPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
	[self.currentPlayerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
	[self.player removeTimeObserver:self.playbackTimeObserver];
	self.playbackTimeObserver = nil;
	self.currentPlayerItem = nil;
}


- (void)monitoringPlayback:(AVPlayerItem *)playerItem
{
	[self.displayView updateCurrentTime:0];
	[self.displayView updateTotolTime:_duration];
	self.displayView.playSlider.maximumValue = _duration;
	__weak __typeof(self)weakSelf = self;
	self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
		__strong __typeof(weakSelf)strongSelf = weakSelf;
		CGFloat current = playerItem.currentTime.value/playerItem.currentTime.timescale;
		if (!strongSelf.displayView.isDragingSlider) {
			[strongSelf.displayView updateCurrentTime:current];
			[strongSelf.displayView.playSlider setValue:current animated:NO];
		}
	}];
}

- (void)setLoadedProgress:(CGFloat)loadedProgress
{
	if (_loadedProgress == loadedProgress) {
		return;
	}
	_loadedProgress = loadedProgress;
	[[NSNotificationCenter defaultCenter] postNotificationName:kPlayerLoadProgressChangedNotification object:nil];
}

- (void)seekToTime:(CGFloat)seconds
{
	seconds = MAX(0, seconds);
	seconds = MIN(seconds, self.duration);
	[self.player seekToTime:CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
		
	}];
}
- (void)cancelVoiceDownload
{
	[self.downLoadTask cancelDownLoadRequest];
}

#pragma mark - TBVideoRequestTaskDelegate
- (void)didFinishLoadingWithTask:(TBVideoRequestTask *)task
{
	
}

- (void)didFailLoadingWithTask:(TBVideoRequestTask *)task WithError:(NSInteger)errorCode
{
	
}

#pragma mark - VoicePlayerOptionDelegate
- (void)playVoiceOrPauseVoice:(BOOL)flag
{
	if (flag) {
		[self.player play];
	}
	else {
		[self.player pause];
	}
}

- (void)playIndicatorTime:(float)value
{
	[self seekToTime:value];
}

#pragma mark - 更改进度条
- (void)calculateDownloadProgress:(AVPlayerItem *)playerItem
{
	NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
	CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
	float startSeconds = CMTimeGetSeconds(timeRange.start);
	float durationSeconds = CMTimeGetSeconds(timeRange.duration);
	NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
	CMTime duration = playerItem.duration;
	CGFloat totalDuration = CMTimeGetSeconds(duration);
	self.loadedProgress = timeInterval / totalDuration;
	[self.displayView.videoProgressView setProgress:timeInterval / totalDuration animated:YES];
}
#pragma mark - AVAssetResourceLoaderDelegate
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest
{
	return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest
{
	
}
#pragma mark - KVC
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	AVPlayerItem *playerItem = (AVPlayerItem *)object;
	if ([keyPath isEqualToString:@"status"])
	{
		if ([playerItem status] == AVPlayerStatusReadyToPlay) {
			self.duration = floorf(CMTimeGetSeconds([[[self player] currentItem] duration]));
			[self monitoringPlayback:playerItem];// 给播放器添加计时器
		}
		else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerStatusUnknown) {
			NSLog(@"%@",self.player.currentItem.error);
			[self.displayView resumeOrPauseFlag:NO];
		}
	}
	else if ([keyPath isEqualToString:@"loadedTimeRanges"])
	{
		[self calculateDownloadProgress:playerItem];
	}
	else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"])
	{
		NSLog(@"1");
	}
	else if ([keyPath isEqualToString:@"playbackBufferEmpty"])
	{
		NSLog(@"2");

	}
}

#pragma mark - KVO_Method
- (void)playerItemDidPlayToEnd:(NSNotification *)notification
{
	[self.displayView resumeOrPauseFlag:NO];
}

@end
