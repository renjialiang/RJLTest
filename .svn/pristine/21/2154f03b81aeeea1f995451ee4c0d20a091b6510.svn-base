//
//  RJLCFNetWorkController.m
//  RJLTestPro
//
//  Created by mini on 16/3/31.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLCFNetWorkController.h"
#import <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#define kBufferSize 1024

@interface RJLCFNetWorkController ()
{
	NSMutableData * _receivedData;
}
- (void)didReceiveData:(NSData *)data;
- (void)didFinishReceivingData;
@end

@implementation RJLCFNetWorkController
- (void)printInMyTextView:(NSString *)str
{
	__weak __typeof(self)weakSelf = self;
	dispatch_main_async_safe((^{
		__strong __typeof(weakSelf)strongSelf = weakSelf;
		strongSelf.playTextView.text = [strongSelf.playTextView.text stringByAppendingString:[NSString stringWithFormat:@"%@\n",str]];
	}));
}

- (void)clearMyTextView
{
	_playTextView.text = @"";
}

- (void)didRequestURL:(id)sender
{
	if (_inputURLText.text.length > 0) {
		if (![RJLCFNetWorkController validdateUrlString:_inputURLText.text]) {
			[self printInMyTextView:[NSString stringWithFormat:@"URL input not conform to the rules"]];
			return;
		}
		[self clearMyTextView];
		[self printInMyTextView:[NSString stringWithFormat:@"Start connect %@",_inputURLText.text]];
		NSThread * backgroundThread = [[NSThread alloc] initWithTarget:self
															  selector:@selector(loadDataFromServerWithURLString:)
																object:_inputURLText.text];
		[backgroundThread start];
		_inputURLText.enabled = NO;
		_connectBtn.enabled = NO;
//		[self loadDataFromHttpRequestWithURLString:nil];
	}
	else {
		return;
	}
}

- (void)didReceiveData:(NSData *)data {
	if (_receivedData == nil) {
		_receivedData = [[NSMutableData alloc] init];
	}
	
	[_receivedData appendData:data];
	
	// Update UI
	//
	__weak __typeof(self)weakSelf = self;
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		NSString * resultsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		__strong __typeof(weakSelf)strongSelf = weakSelf;
		[strongSelf printInMyTextView:resultsString];
	}];
}

- (void)didFinishReceivingData
{
	[self networkSucceedWithData:_receivedData];
}

+ (BOOL)validdateUrlString:(NSString *)urlString
{
	if (!urlString) {
		return NO;
	}
	NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
	NSRange urlStringRange = NSMakeRange(0, [urlString length]);
	NSMatchingOptions matchOptions = 0;
	if (1 != [linkDetector numberOfMatchesInString:urlString options:matchOptions range:urlStringRange]) {
		return NO;
	}
	NSTextCheckingResult *checkingResult = [linkDetector firstMatchInString:urlString options:matchOptions range:urlStringRange];
	return checkingResult.resultType == NSTextCheckingTypeLink && NSEqualRanges(checkingResult.range, urlStringRange);
}

- (void)networkFailedWithErrorMessage:(NSString *)message
{
	// Update UI
	//
	__weak __typeof(self)weakSelf = self;
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		__strong __typeof(weakSelf)strongSelf = weakSelf;
		[strongSelf printInMyTextView:message];
		strongSelf.connectBtn.enabled = YES;
		strongSelf.inputURLText.enabled = YES;
	}];
}

- (void)networkSucceedWithData:(NSData *)data
{
	// Update UI
	//
	__weak __typeof(self)weakSelf = self;
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		NSString * resultsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		__strong __typeof(weakSelf)strongSelf = weakSelf;
		[strongSelf printInMyTextView:[NSString stringWithFormat:@" >> Received string: '%@'", resultsString]];
		strongSelf.connectBtn.enabled = YES;
		strongSelf.inputURLText.enabled = YES;
	}];
}
#pragma mark Socket
- (void)loadDataFromServerWithURLString:(NSString *)url
{
	NSURL *requestUrl = [NSURL URLWithString:url];
	NSString	*host = [requestUrl host];
	NSInteger	port =  [[requestUrl port] integerValue];
	//Keep a reference to self to use for controller callbacks
	//
	CFStreamClientContext ctx = {0, (__bridge void *)(self), NULL, NULL, NULL};
	//Get callbacks for stream data, stream end, and any errors
	//
	CFOptionFlags registerdEvents = (kCFStreamEventHasBytesAvailable | kCFStreamEventEndEncountered | kCFStreamEventErrorOccurred);
	//Create a read-only socket
	//
	CFReadStreamRef readStream;
	CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)host, (int)port, &readStream, NULL);
	//Schedule the stream on the run loop to enable callbacks
	//
	if (CFReadStreamSetClient(readStream, registerdEvents, socketCallback, &ctx)) {
		CFReadStreamScheduleWithRunLoop(readStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
	}
	else {
		return;
	}
	//Open the stream for reading
	//
	if (CFReadStreamOpen(readStream) == NO) {
		[self networkFailedWithErrorMessage:@"Failed to open read stream"];
		return;
	}
	CFErrorRef error = CFReadStreamCopyError(readStream);
	if (error != NULL) {
		if (CFErrorGetCode(error) != 0) {
			NSString *errorInfo = [NSString stringWithFormat:@"error:%@ (code %ld)", (__bridge NSString *)CFErrorGetDomain(error), CFErrorGetCode(error)];
			[self printInMyTextView:errorInfo];
		}
		CFRelease(error);
		return;
	}
	//Start processing
	//
	[self printInMyTextView:[NSString stringWithFormat:@"Successfully connected to %@",url]];
	CFRunLoopRun();
}

void socketCallback(CFReadStreamRef stream, CFStreamEventType event, void *myPtr)
{
	RJLCFNetWorkController * controller = (__bridge RJLCFNetWorkController *)myPtr;
	[controller printInMyTextView:[NSString stringWithFormat:@" >> socketCallback in Thread %@", [NSThread currentThread]]];
	switch (event) {
		case kCFStreamEventHasBytesAvailable:
			{
				// Read bytes until there are no more
				//
				while (CFReadStreamHasBytesAvailable(stream)) {
					UInt8 buffer[kBufferSize];
					int numBytesRead = CFReadStreamRead(stream, buffer, kBufferSize);
					[controller didReceiveData:[NSData dataWithBytes:buffer length:numBytesRead]];
				}
				break;
			}
		case kCFStreamEventErrorOccurred: {
			CFErrorRef error = CFReadStreamCopyError(stream);
			if (error != NULL) {
				if (CFErrorGetCode(error) != 0) {
					NSString * errorInfo = [NSString stringWithFormat:@"Failed while reading stream; error '%@' (code %ld)", (__bridge NSString*)CFErrorGetDomain(error), CFErrorGetCode(error)];
					[controller networkFailedWithErrorMessage:errorInfo];
				}
				CFRelease(error);
			}
			break;
		}
		case kCFStreamEventEndEncountered:
			// Finnish receiveing data
			//
			[controller didFinishReceivingData];
			
			// Clean up
			//
			CFReadStreamClose(stream);
			CFReadStreamUnscheduleFromRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
			CFRunLoopStop(CFRunLoopGetCurrent());
			break;
		default:
			break;
	}
}

#pragma -mark CFNetWorkHttp
//void myCFReadStreamClientCallBack1(CFReadStreamRef stream, CFStreamEventType type, void *clientCallBackInfo) {
//	CFHTTPMessageRef response = (CFHTTPMessageRef)clientCallBackInfo;
//	if (type == kCFStreamEventEndEncountered) {
//		CFIndex statusCode = CFHTTPMessageGetResponseStatusCode(response);
//		if (statusCode == 200) {
//			CFDataRef responseData = CFHTTPMessageCopyBody(response);
//			CFStringRef responseWebPage = CFStringCreateWithBytes(kCFAllocatorDefault, CFDataGetBytePtr(responseData), CFDataGetLength(responseData), kCFStringEncodingUTF8, YES);
//			NSLog(@"方式2:\n%s", CFDataGetBytePtr(responseData));
////			CFRelease(responseData);
////			CFRelease(responseWebPage);
//		}
//	} else if (type == kCFStreamEventErrorOccurred) {
//		CFReadStreamUnscheduleFromRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
//		CFReadStreamClose(stream);
//		CFRelease(stream);
//		stream = NULL;
//	} else if (type == kCFStreamEventHasBytesAvailable) {
//		
//		//获取http response的header，转换成字典
//		
//		CFTypeRef message =
//		CFReadStreamCopyProperty(stream, kCFStreamPropertyHTTPResponseHeader);
//		NSDictionary* httpHeaders =
//		(__bridge NSDictionary *)CFHTTPMessageCopyAllHeaderFields((CFHTTPMessageRef)message);
//		NSLog(@"dic:%@",httpHeaders);
////		CFRelease(message);
//		UInt8 buffer[2048];
//		//回调读取数据时，读取的都是body的内容，response header自动被封装处理好的。
//		CFIndex length = CFReadStreamRead(stream, buffer, sizeof(buffer));
//		CFHTTPMessageAppendBytes(response, buffer, length);
//	}
//}
//
//
//- (void)loadDataFromHttpRequestWithURLString:(NSString *)urlString
//{
//	CFStringRef url = CFSTR("http://www.51ifind.com/images/icons/yqjkL.png");
//	CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault, url, NULL);// note: release
//	CFStringRef requestMethod = CFSTR("POST");
//	CFHTTPMessageRef myRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault, requestMethod, myURL, kCFHTTPVersion1_1);// note: release
//	// 设置body
//	const UInt8 bytes[] = "1024124124";
//	int bLength = sizeof(bytes) / sizeof(UInt8);
//	
//	CFDataRef bodyData = CFDataCreate(kCFAllocatorDefault, bytes, 5);// note: release
//	CFHTTPMessageSetBody(myRequest, bodyData);
//	// 设置header
//	CFStringRef headerField = CFSTR("name");
//	CFStringRef value = CFSTR("daniate");
//	CFHTTPMessageSetHeaderFieldValue(myRequest, headerField, value);
//	CFReadStreamRef requestReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, myRequest);// note: release
//	CFHTTPMessageRef response = CFHTTPMessageCreateEmpty(kCFAllocatorDefault, false);
//	CFStreamClientContext clientContext = {0, response, NULL, NULL, NULL};
//	CFOptionFlags flags = kCFStreamEventHasBytesAvailable | kCFStreamEventEndEncountered | kCFStreamEventErrorOccurred;
//	Boolean result = CFReadStreamSetClient(requestReadStream, flags, myCFReadStreamClientCallBack1, &clientContext);
//	if (result) {
//		CFReadStreamScheduleWithRunLoop(requestReadStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
//		if (CFReadStreamOpen(requestReadStream)) {
//			CFRunLoopRun();
//		} else {
//			CFReadStreamUnscheduleFromRunLoop(requestReadStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
//		}
//	}
//	CFRelease(myURL);
//	CFRelease(myRequest);
//	CFRelease(bodyData);
//}

@end
