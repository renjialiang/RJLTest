//
//  WKWebView+JSEngine.h
//  RJLTestPro
//
//  Created by mini on 16/4/7.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <objc/runtime.h>

#ifdef DEBUG
#define JSELOG NSLog
#else
#define JSELOG(...) nil
#endif

typedef void (^WKCallback)(id responseData);
typedef id (^WKSyncHandler)(id data);
typedef void (^WKAsyncHandler)(id data, WKCallback callBack);

@interface WKWebView (JSEngine)
// swizzling delegate setting to do something our own
+ (void)JSE_delegateSwizzling;
// create and initial JS engine
// NOTE: call this AFTER set delegate to webview
- (void)JSE_enableEngine;
// register own unique handler to JS engine so that web html could use it
- (void)JSE_registerNative:(NSString*)handlerName handle:(WKSyncHandler)handler;

- (void)JSE_registerNative:(NSString *)handlerName withAsyncHandle:(WKAsyncHandler)handler;
// execute js functions by JS Engine
- (void)JSE_executeJS:(NSString*)handlerName data:(id)data callback:(WKCallback)callback;
//set WKNavigationDelegate
- (void)setWebViewDelegate:(id)delegate;
@end
