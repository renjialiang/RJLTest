//
//  VoicePlayerView.m
//  RJLTestPro
//
//  Created by mini on 16/8/11.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "VoicePlayerView.h"
@implementation VoicePlayerView
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initUIControls];
	}
	return self;
}

- (void)initUIControls
{
	UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	[bgImageView setImage:[UIImage imageNamed:@"voiceplayerbackground"]];
	[self addSubview:bgImageView];
	//暂停按钮
	if (!self.stopButton) {
		self.stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_stopButton.frame = CGRectMake(10, 9, 22, 22);
		[_stopButton addTarget:self action:@selector(resumeOrPause:) forControlEvents:UIControlEventTouchUpInside];
		[_stopButton setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
		[_stopButton setImage:[UIImage imageNamed:@"icon_pause"] forState:UIControlStateSelected];
		[self addSubview:_stopButton];
	}
	//进度条
	if (!self.videoProgressView) {
		self.videoProgressView = [[UIProgressView alloc] init];
		_videoProgressView.progressTintColor = [UIColor whiteColor];  //填充部分颜色
		_videoProgressView.trackTintColor = [UIColor colorWithRed:179/255.0 green:178/255.0 blue:177/255.0 alpha:1];   // 未填充部分颜色
		_videoProgressView.frame = CGRectMake(35, self.frame.size.height / 2 - 1, self.frame.size.width - 35 - 90, self.frame.size.height / 2);
		_videoProgressView.layer.cornerRadius = 1.5;
		_videoProgressView.layer.masksToBounds = YES;
		CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.5);
		_videoProgressView.transform = transform;
		[self addSubview:_videoProgressView];
	}
	//滑竿
	if (!self.playSlider) {
		self.playSlider = [[UISlider alloc] init];
		_playSlider.frame = CGRectMake(35, 2, self.frame.size.width - 35 - 90, self.frame.size.height);
		_playSlider.minimumTrackTintColor = [UIColor clearColor];
		_playSlider.maximumTrackTintColor = [UIColor clearColor];
		[_playSlider setThumbImage:[UIImage imageNamed:@"thumbimage"] forState:UIControlStateNormal];
		_playSlider.minimumValue = 0.0;
		[_playSlider addTarget:self action:@selector(playSliderChange:) forControlEvents:UIControlEventValueChanged]; //拖动滑竿更新时
		[_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpInside];  //松手,滑块拖动停止
		[_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpOutside];
		[_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchCancel];
		_isDragingSlider = NO;
		[self addSubview:_playSlider];
	}
	
	if (!self.currentTimeLabel) {
		self.currentTimeLabel = [[UILabel alloc] init];
		_currentTimeLabel.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1];
		_currentTimeLabel.font = [UIFont systemFontOfSize:12.0];
		_currentTimeLabel.frame = CGRectMake(_videoProgressView.frame.origin.x + _videoProgressView.frame.size.width + 5, 0, 40, self.frame.size.height);
		_currentTimeLabel.textAlignment = NSTextAlignmentRight;
		[self addSubview:_currentTimeLabel];
	}
	//总时间
	if (!self.totolTimeLabel) {
		self.totolTimeLabel = [[UILabel alloc] init];
		_totolTimeLabel.textColor = [UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1];
		_totolTimeLabel.font = [UIFont systemFontOfSize:12.0];
		_totolTimeLabel.frame = CGRectMake(_currentTimeLabel.frame.origin.x + _currentTimeLabel.frame.size.width, 0, 40, self.frame.size.height);
		_totolTimeLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:_totolTimeLabel];
	}
}

- (void)resumeOrPause:(UIButton *)sender
{
	sender.selected = !sender.selected;
	if (_delegate && [_delegate respondsToSelector:@selector(playVoiceOrPauseVoice:)]) {
		[_delegate playVoiceOrPauseVoice:sender.selected];
	}
}

- (void)resumeOrPauseFlag:(BOOL)selected
{	
	self.stopButton.selected = selected;
	if (_delegate && [_delegate respondsToSelector:@selector(playVoiceOrPauseVoice:)]) {
		[_delegate playVoiceOrPauseVoice:selected];
	}
}

- (void)playSliderChange:(UISlider *)slider
{
	_isDragingSlider = YES;
	[self updateCurrentTime:slider.value];
}

- (void)playSliderChangeEnd:(UISlider *)slider
{
	if (_delegate && [_delegate respondsToSelector:@selector(playIndicatorTime:)]) {
		[_delegate playIndicatorTime:slider.value];
	}
	[self updateCurrentTime:slider.value];
	_isDragingSlider = NO;
}


- (void)updateCurrentTime:(CGFloat)time
{
	long videocurrent = ceil(time);
	NSString *str = nil;
	if (videocurrent < 3600) {
		str =  [NSString stringWithFormat:@"%02li:%02li",lround(floor(videocurrent/60.f)),lround(floor(videocurrent/1.f))%60];
	} else {
		str =  [NSString stringWithFormat:@"%02li:%02li:%02li",lround(floor(videocurrent/3600.f)),lround(floor(videocurrent%3600)/60.f),lround(floor(videocurrent/1.f))%60];
	}
	_currentTimeLabel.text = str;
}

- (void)updateTotolTime:(CGFloat)time
{
	long videoLenth = ceil(time);
	NSString *strtotol = nil;
	if (videoLenth < 3600) {
		strtotol =  [NSString stringWithFormat:@"/%02li:%02li",lround(floor(videoLenth/60.f)),lround(floor(videoLenth/1.f))%60];
	} else {
		strtotol =  [NSString stringWithFormat:@"/%02li:%02li:%02li",lround(floor(videoLenth/3600.f)),lround(floor(videoLenth%3600)/60.f),lround(floor(videoLenth/1.f))%60];
	}
	_totolTimeLabel.text = strtotol;
}

@end
