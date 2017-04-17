//
//  RJLDownLoad.m
//  RJLTestPro
//
//  Created by mini on 16/4/1.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLDownLoad.h"
@interface RJLDownLoad () <NSURLConnectionDelegate>

@property (strong, nonatomic) NSOutputStream *downloadStream;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSString *tempFilename;
@property (nonatomic) BOOL isCancel;
@property (nonatomic, strong) NSThread *backGroundThread;
@end
@implementation RJLDownLoad
#pragma mark - Public methods

- (instancetype)initWithFilename:(NSString *)filename URL:(NSURL *)url delegate:(id<RJLDownloadDelegate>)delegate
{
	self = [super init];
	
	if (self) {
		_filename = [filename copy];
		_url = [url copy];
		_delegate = delegate;
		_isCancel = NO;
	}
	
	return self;
}

- (void)threadStart
{
//	do {
//		@autoreleasepool
//		{
//			[[NSRunLoop currentRunLoop] run];
////			CFRunLoopRunInMode(kCFRunLoopDefaultMode, [NSDate distantFuture], YES);
//			BOOL ret = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//			NSLog(@"exit worker thread runloop: %d", ret);
//		}
//	} while (!_isCancel);
	NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
//	NSMachPort* dummyPort = [[NSMachPort alloc]init];
//	[runLoop addPort:dummyPort forMode:NSDefaultRunLoopMode];
	
	
	
	while (!_isCancel) //加循环条件
	{
		[runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	}
}

- (void)startWithThread
{
	[self performSelector:@selector(start) onThread:[self startrafsf]   withObject:nil waitUntilDone:NO];
}

- (NSThread *)startrafsf
{
	self.backGroundThread = [[NSThread alloc] initWithTarget:self
														  selector:@selector(threadStart)
															object:nil];
	[self.backGroundThread start];
	return self.backGroundThread;
}

- (void)start
{
	// initialize progress variables
	
	self.downloading = YES;
	self.expectedContentLength = -1;
	self.progressContentLength = 0;
	
	// create the download file stream (so we can write the file as we download it
	
	self.tempFilename = [self pathForTemporaryFileWithPrefix:@"downloads"];
	self.downloadStream = [NSOutputStream outputStreamToFileAtPath:self.tempFilename append:NO];
	if (!self.downloadStream) {
		self.error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
										 code:-1
									 userInfo:@{@"message": @"Unable to create NSOutputStream", @"function" : @(__FUNCTION__), @"path" : self.tempFilename}];
		
		[self cleanupConnectionSuccessful:NO];
		return;
	}
	[self.downloadStream open];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:self.overTimeLimit];
	if (!request) {
		self.error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
										 code:-1
									 userInfo:@{@"message": @"Unable to create URL", @"function": @(__FUNCTION__), @"URL" : self.url}];
		
		[self cleanupConnectionSuccessful:NO];
		return;
	}
	
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
	[self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[self.connection start];
	
	NSLog(@"%@",self.url);
	if (!self.connection) {
		self.error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
										 code:-1
									 userInfo:@{@"message": @"Unable to create NSURLConnection", @"function" : @(__FUNCTION__), @"NSURLRequest" : request}];
		
		[self cleanupConnectionSuccessful:NO];
	}
}

- (void)cancel
{
	[self cleanupConnectionSuccessful:NO];
}

#pragma mark - Private methods

- (BOOL)createFolderForPath:(NSString *)filePath
{
	NSError *error;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *folder = [filePath stringByDeletingLastPathComponent];
	BOOL isDirectory;
	
	if (![fileManager fileExistsAtPath:folder isDirectory:&isDirectory]) {
		// if folder doesn't exist, try to create it
		
		[fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:&error];
		
		// if fail, report error
		
		if (self.error) {
			self.error = error;
			return FALSE;
		}
		
		// directory successfully created
		
		return TRUE;
	} else if (!isDirectory) {
		self.error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
										 code:-1
									 userInfo:@{@"message": @"Unable to create directory; file exists by that name", @"function" : @(__FUNCTION__), @"folder": folder}];
		return FALSE;
	}
	
	// directory already existed
	
	return TRUE;
}

- (void)cleanupConnectionSuccessful:(BOOL)success
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
	// clean up connection and download steam
	
	if (self.connection != nil) {
		if (!success) {
			[self.connection cancel];
		}
		self.connection = nil;
	}
	if (self.downloadStream != nil) {
		[self.downloadStream close];
		self.downloadStream = nil;
	}
	
	self.downloading = NO;
	
	// if successful, move file and clean up, otherwise just cleanup
	
	if (success) {
		if (![self createFolderForPath:self.filename]) {
			[self.delegate downloadDidFail:self];
			return;
		}
		
		if ([fileManager fileExistsAtPath:self.filename]) {
			[fileManager removeItemAtPath:self.filename error:&error];
			if (error) {
				self.error = error;
				[self.delegate downloadDidFail:self];
				return;
			}
		}
		
		[fileManager copyItemAtPath:self.tempFilename toPath:self.filename error:&error];
		if (error) {
			self.error = error;
			[self.delegate downloadDidFail:self];
			return;
		}
		
		[fileManager removeItemAtPath:self.tempFilename error:&error];
		if (error) {
			self.error = error;
			[self.delegate downloadDidFail:self];
			return;
		}
		
		[self.delegate downloadDidFinishLoading:self];
	}
	else
	{
		if (self.tempFilename)
			if ([fileManager fileExistsAtPath:self.tempFilename])
				[fileManager removeItemAtPath:self.tempFilename error:&error];
		
		[self.delegate downloadDidFail:self];
	}
}

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix
{
	NSString *  result;
	CFUUIDRef   uuid;
	CFStringRef uuidStr;
	
	uuid = CFUUIDCreate(NULL);
	assert(uuid != NULL);
	
	uuidStr = CFUUIDCreateString(NULL, uuid);
	assert(uuidStr != NULL);
	
	result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
	assert(result != nil);
	
	CFRelease(uuidStr);
	CFRelease(uuid);
	
	return result;
}
#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
//	NSLog(@"%@",[NSString stringWithFormat:@" >> socketCallback in Thread %@", [NSThread currentThread]]);
	if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
		NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
		
		if (statusCode == 200) {
			self.expectedContentLength = [response expectedContentLength];
		} else if (statusCode >= 400) {
			self.error = [NSError errorWithDomain:[NSBundle mainBundle].bundleIdentifier
											 code:statusCode
										 userInfo:@{
													@"message" : @"bad HTTP response status code",
													@"function": @(__FUNCTION__),
													@"NSHTTPURLResponse" : response
													}];
			[self cleanupConnectionSuccessful:NO];
		}
	} else {
		self.expectedContentLength = -1;
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSString *strRet = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
	NSData * unCompressData=[strRet dataUsingEncoding:NSUTF8StringEncoding];
	NSError* error=nil;
	NSDictionary* jsonObject=[NSJSONSerialization JSONObjectWithData:unCompressData options:NSJSONReadingMutableLeaves error:&error];
	NSLog(@"%@",jsonObject);
//	NSInteger       dataLength = [data length];
//	const uint8_t * dataBytes  = [data bytes];
//	NSInteger       bytesWritten;
//	NSInteger       bytesWrittenSoFar;
//	
//	bytesWrittenSoFar = 0;
//	do {
//		bytesWritten = [self.downloadStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
//		assert(bytesWritten != 0);
//		if (bytesWritten == -1) {
//			[self cleanupConnectionSuccessful:NO];
//			break;
//		} else {
//			bytesWrittenSoFar += bytesWritten;
//		}
//	} while (bytesWrittenSoFar != dataLength);
//	
//	self.progressContentLength += dataLength;
//	
//	if ([self.delegate respondsToSelector:@selector(downloadDidReceiveData:)])
//		[self.delegate downloadDidReceiveData:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self cleanupConnectionSuccessful:YES];
	if (self.backGroundThread) {
		NSLog(@"关闭线程");
		_isCancel = YES;
		[self.backGroundThread cancel];
		self.backGroundThread = nil;
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	self.error = error;
	
	[self cleanupConnectionSuccessful:NO];
}
@end
