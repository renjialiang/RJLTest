//
//  UIWebView+JSEngine.h
//  webtest
//
//  Created by 王学飞 on 14-2-12.
//  Copyright (c) 2014年 王学飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// Enable debug log
#ifdef DEBUG
#define JSELOG NSLog
#else
#define JSELOG(...) nil
#endif

typedef void (^Callback)(id responseData);
typedef id (^SyncHandler)(id data);

@interface UIWebView (JSEngine)

// swizzling delegate setting to do something our own
+ (void)JSE_delegateSwizzling;

// create and initial JS engine
// NOTE: call this AFTER set delegate to webview
- (void)JSE_enableEngine;

// register own unique handler to JS engine so that web html could use it
- (void)JSE_registerNative:(NSString*)handlerName handle:(SyncHandler)handler;

// execute js functions by JS Engine
- (void)JSE_executeJS:(NSString*)handlerName data:(id)data callback:(Callback)callback;

//set WebViewDeleage 
- (void)setWebViewDelegate:(id)delegate;

@end
