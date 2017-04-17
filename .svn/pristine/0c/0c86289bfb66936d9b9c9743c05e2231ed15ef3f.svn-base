//
//  TBVideoRequestTask.m
//  avplayerSavebufferData
//
//  Created by qianjianeng on 15/9/18.
//  Copyright (c) 2015年 qianjianeng. All rights reserved.
//

#import "TBVideoRequestTask.h"
NSString *const kVoiceURLSession = @"RJLVoiceURLSession";
@interface TBVideoRequestTask () <NSURLSessionDataDelegate, AVAssetResourceLoaderDelegate>
@property (nonatomic, strong) NSURLSessionDataTask *urlDownLoadTask;
@property (nonatomic, strong) NSURLSession *currentSession;
@property (nonatomic, strong) NSURL           *url;
@property (nonatomic) NSUInteger      offset;
@property (nonatomic) NSUInteger      videoLength;
@property (nonatomic) NSUInteger      downLoadingOffset;
@property (nonatomic, strong) NSString        *mimeType;
@property (nonatomic, strong) NSFileHandle    *fileHandle;
@property (nonatomic, strong) NSString        *tempPath;
@property (nonatomic, strong) NSString		  *fileName;
@end

@implementation TBVideoRequestTask

- (instancetype)initWithFileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
		_fileName = fileName;
        _tempPath =  [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3.td",self.fileName]];
        if (![[NSFileManager defaultManager] fileExistsAtPath:_tempPath]) {
            [[NSFileManager defaultManager] createFileAtPath:_tempPath contents:nil attributes:nil];
        }
    }
    return self;
}

- (void)setUrl:(NSURL *)url offset:(NSUInteger)offset
{
    _url = url;
    _offset = offset;
    _downLoadingOffset = 0;
    NSURLComponents *actualURLComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    actualURLComponents.scheme = @"http";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[actualURLComponents URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
    
    if (offset > 0) {
        [request addValue:[NSString stringWithFormat:@"bytes=%ld-",(unsigned long)offset] forHTTPHeaderField:@"Range"];
    }
	
	if (!self.currentSession) {
		[self createCurrentSession];
	}
	if (self.urlDownLoadTask) {
		[self.urlDownLoadTask cancel];
	}
	self.urlDownLoadTask = [self.currentSession dataTaskWithRequest:request];
	[self.urlDownLoadTask resume];
}

- (void)createCurrentSession{
	NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
	self.currentSession = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:nil];
	self.currentSession.sessionDescription = kVoiceURLSession;
}


- (void)cancelDownLoadRequest
{
	[self.urlDownLoadTask cancel];
}

- (void)clearData
{
    [[NSFileManager defaultManager] removeItemAtPath:_tempPath error:nil];
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
	NSDictionary *dic = (NSDictionary *)[httpResponse allHeaderFields] ;
	NSString *content = [dic valueForKey:@"Content-Range"];
	NSArray *array = [content componentsSeparatedByString:@"/"];
	NSString *length = array.lastObject;
	NSUInteger videoLength;
	if ([length integerValue] == 0) {
		videoLength = (NSUInteger)httpResponse.expectedContentLength;
	} else {
		videoLength = [length integerValue];
	}
	self.videoLength = videoLength;
	self.mimeType = @"temp/mp3";
	if ([self.delegate respondsToSelector:@selector(task:didReceiveVideoLength:mimeType:)])
	{
		[self.delegate task:self didReceiveVideoLength:self.videoLength mimeType:self.mimeType];
	}
	self.fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:_tempPath];
	completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
	[self.fileHandle seekToEndOfFile];
	[self.fileHandle writeData:data];
	_downLoadingOffset += data.length;
	NSLog(@"%lu",_downLoadingOffset);
	if ([self.delegate respondsToSelector:@selector(didReceiveVideoDataWithTask:)]) {
		[self.delegate didReceiveVideoDataWithTask:self];
	}
}
#pragma Mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
	if (error == nil) {
		NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
		NSString *movePath = nil;
		if (self.fileName && self.fileName.length > 0) {
			movePath =  [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.acc",self.fileName]];
		}
		else {
			movePath =  [document stringByAppendingPathComponent:@"保存数据.mp3"];
		}
		BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:_tempPath toPath:movePath error:nil];
		if (isSuccess) {
			[self clearData];
			_tempPath = movePath;
		}
		else {
			NSLog(@"rename fail");
		}
		if ([self.delegate respondsToSelector:@selector(didFinishLoadingWithTask:)]) {
			[self.delegate didFinishLoadingWithTask:self];
		}
	}
	else {
		if (error.code == -1001) {
			
		}
		if ([self.delegate respondsToSelector:@selector(didFailLoadingWithTask:WithError:)]) {
			[self.delegate didFailLoadingWithTask:self WithError:error.code];
		}
		if (error.code == -1009) {
			
		}
	}
}

@end
