//
//  RJLDownLoad.h
//  RJLTestPro
//
//  Created by mini on 16/4/1.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Download;

/** The `Download` class defines a delegate protocol, `DownloadDelegate`,
 * to inform the `delegate` regarding the success or failure of a download.
 *
 * @see Download
 */
@class RJLDownLoad;

@protocol RJLDownloadDelegate <NSObject>
@optional


- (void)downloadDidFinishLoading:(RJLDownLoad *)download;



- (void)downloadDidFail:(RJLDownLoad *)download;


- (void)downloadDidReceiveData:(RJLDownLoad *)download;

@end
@interface RJLDownLoad : NSObject <NSURLConnectionDataDelegate>
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic) NSTimeInterval overTimeLimit;
@property (nonatomic, weak) id<RJLDownloadDelegate> delegate;
@property (getter = isDownloading) BOOL downloading;
@property (nonatomic, strong) NSError *error;
@property long long expectedContentLength;
@property long long progressContentLength;
- (id)initWithFilename:(NSString *)filename URL:(NSURL *)url delegate:(id<RJLDownloadDelegate>)delegate;

/// @name Control

/// Start the individual download.
- (void)startWithThread;
- (void)start;

/// Cancel the individual download, whether in progress or simply pending.

- (void)cancel;
@end
