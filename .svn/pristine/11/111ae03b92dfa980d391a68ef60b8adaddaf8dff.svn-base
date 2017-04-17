//
//  CoreTextViewController.m
//  RJLTestPro
//
//  Created by mini on 16/6/13.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "CoreTextViewController.h"
#import "CoreTextDisplayView.h"
#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"
#import "CoreTextLinkData.h"
@interface CoreTextViewController ()

@end

@implementation CoreTextViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setupUserInterface];
	[self setupNotifications];
}

- (void)setupUserInterface {
	CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
	config.width = self.view.width;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
	CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
	((CoreTextDisplayView *)self.view).data = data;
	self.view.height = data.height;
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupNotifications {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePressed:)
												 name:CTDisplayViewImagePressedNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkPressed:)
												 name:CTDisplayViewLinkPressedNotification object:nil];
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)imagePressed:(NSNotification*)notification {
	NSDictionary *userInfo = [notification userInfo];
	CoreImageData *imageData = userInfo[@"imageData"];
	debugLog(@"%@",userInfo);
//	ImageViewController *vc = [[ImageViewController alloc] init];
//	vc.image = [UIImage imageNamed:imageData.name];
//	[self presentViewController:vc animated:YES completion:nil];
}

- (void)linkPressed:(NSNotification*)notification {
	NSDictionary *userInfo = [notification userInfo];
	CoreTextLinkData *linkData = userInfo[@"linkData"];
	debugLog(@"%@",userInfo);

//	WebContentViewController *vc = [[WebContentViewController alloc] init];
//	vc.urlTitle = linkData.title;
//	vc.url = linkData.url;
//	[self presentViewController:vc animated:YES completion:nil];
}

@end
