//
//  VoicePlayerView.h
//  RJLTestPro
//
//  Created by mini on 16/8/11.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoicePlayer.h"
@protocol VoicePlayerOptionDelegate <NSObject>
- (void)playVoiceOrPauseVoice:(BOOL)flag;
- (void)playIndicatorTime:(float)value;
@end

@interface VoicePlayerView : UIView
@property (nonatomic, weak) id <VoicePlayerOptionDelegate> delegate;
@property (nonatomic, strong) UIView         *navBar;
@property (nonatomic, strong) UILabel        *currentTimeLabel;
@property (nonatomic, strong) UILabel        *totolTimeLabel;
@property (nonatomic, strong) UIProgressView *videoProgressView;
@property (nonatomic, strong) UISlider       *playSlider;  //滑竿
@property (nonatomic, strong) UIButton       *stopButton;//播放暂停按钮
@property (nonatomic) BOOL			 isDragingSlider;
- (void)updateCurrentTime:(CGFloat)time;
- (void)updateTotolTime:(CGFloat)time;
- (void)resumeOrPauseFlag:(BOOL)selected;
@end
