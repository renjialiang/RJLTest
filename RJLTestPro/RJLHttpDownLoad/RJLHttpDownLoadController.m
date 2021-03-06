//
//  RJLHttpDownLoadController.m
//  RJLTestPro
//
//  Created by mini on 16/4/1.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLHttpDownLoadController.h"
#import "RJLCFNetWorkController.h"
#import "PTThreadDownloader.h"
@interface RJLHttpDownLoadController ()
@property (nonatomic) NSInteger buttonClickCount;

@end

@implementation RJLHttpDownLoadController 

- (void)viewWillAppear:(BOOL)animated
{
	self.buttonClickCount = 1;
	_playProgressView.progress = 0;
}
- (void)didRequestURL:(id)sender
{
//	NSString *URLString = @"http://www.51ifind.com/images/icons/mgtjbbL.png";
//	
//	//Use PTNormalDownloaler
//	//    PTNormalDownloaler *downloader = [PTNormalDownloaler
//	//                                      downloadWithURL:[NSURL URLWithString:URLString]
//	//                                      timeoutInterval:15
//	//                                              success:^(id responseData){
//	//                                                  NSLog(@"get data size: %d", [(NSData *)responseData length]);
//	//                                                  NSLog(@"success block in main thread?: %d", [NSThread isMainThread]);
//	//                                              }
//	//                                              failure:^(NSError *error){
//	//                                                  NSLog(@"failure block in main thread?: %d", [NSThread isMainThread]);
//	//                                              }];
//	
//	//Use PTThreadDownloaler
//	PTThreadDownloader *downloader = [PTThreadDownloader
//									  downloadWithURL:[NSURL URLWithString:URLString]
//									  timeoutInterval:15
//									  success:^(id responseData){
//										  NSLog(@"get data size: %d", [(NSData *)responseData length]);
//										  NSLog(@"success block in main thread?: %d", [NSThread isMainThread]);
//									  }
//									  failure:^(NSError *error){
//										  NSLog(@"failure block in main thread?: %d", [NSThread isMainThread]);
//									  }];
	
	if (_inputURLText.text.length > 0) {
	}
	else {
		
		NSString *str = nil;
		if (self.buttonClickCount % 2 == 0) {
			str = @"http://testft.10jqka.com.cn/thsft/iFindService/CellPhone/i-strategy/get-view-interaction-number?ifindid=10004057&&postid=2607&account=智能投资";
		}
		else {
			str = @"http://testft.10jqka.com.cn/thsft/iFindService/CellPhone/i-strategy/ajax-view-list-client?strategy_id=4055&page=1";
		}
		if (![RJLCFNetWorkController validdateUrlString:str]) {
			NSLog(@"URL input not conform to the rules");
			return;
		}
		NSString* urlEncode = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
		self.buttonClickCount ++;
		NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
		NSString *downloadFolder = [documentsPath stringByAppendingPathComponent:@"downloads"];
//		NSLog(@"%@",[NSString stringWithFormat:@"Start connect %@",_inputURLText.text]);
		NSString *downloadFilename = [downloadFolder stringByAppendingPathComponent:[str lastPathComponent]];
		
		NSURL *url = [NSURL URLWithString:urlEncode];
		
		RJLDownLoad *down = [[RJLDownLoad alloc]initWithFilename:downloadFilename URL:url delegate:self];
		if (self.buttonClickCount % 2 == 0) {
			down.overTimeLimit = 30;
		}
		else {
			down.overTimeLimit = 10;
		}
		[down startWithThread];
//		NSThread * backgroundThread = [[NSThread alloc] initWithTarget:_downLoader
//															  selector:@selector(startWithThread)
//																object:nil];
//		[backgroundThread start];
	}
}

- (void)loadDataFromServerWithURLString
{
//	NSLog(@"%@",[NSString stringWithFormat:@" >> socketCallback in Thread %@", [NSThread currentThread]]);
//	NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//	NSString *downloadFolder = [documentsPath stringByAppendingPathComponent:@"downloads"];
//	NSLog(@"%@",[NSString stringWithFormat:@"Start connect %@",_inputURLText.text]);
//	NSString *downloadFilename = [downloadFolder stringByAppendingPathComponent:[_inputURLText.text lastPathComponent]];
//	NSURL *url = [NSURL URLWithString:_inputURLText.text];
//
//	_downLoader = [[RJLDownLoad alloc]initWithFilename:downloadFilename URL:url delegate:self];
//	[_downLoader start];
}

#pragma -mark RJLDownloadDelegate
- (void)downloadDidFinishLoading:(RJLDownLoad *)download
{
	NSLog(@"%@",[NSString stringWithFormat:@" >> socketCallback in Thread %@", [NSThread currentThread]]);
//	NSLog(@"request success");
}

- (void)downloadDidFail:(RJLDownLoad *)download
{
	NSLog(@"%@",[NSString stringWithFormat:@" >> socketCallback in Thread %@", [NSThread currentThread]]);
//	NSLog(@"request failed");
}

- (void)downloadDidReceiveData:(RJLDownLoad *)download
{
	NSLog(@"%@",[NSString stringWithFormat:@" >> socketCallback in Thread %@", [NSThread currentThread]]);
	_playProgressView.progress = (double) download.progressContentLength / (double) download.expectedContentLength;
//	NSLog(@"%lf",_playProgressView.progress);
}
@end
