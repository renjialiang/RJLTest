//
//  WKWebView+JSEngine.m
//  RJLTestPro
//
//  Created by mini on 16/4/7.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "WKWebView+JSEngine.h"
#import "WKWebViewJavascriptBridge.h"

const char *wkkeyBridge = "WKJSBRIDGE";

@implementation WKWebView (JSEngine)

+ (void)JSE_delegateSwizzling
{
	Method ori_Method = class_getInstanceMethod([WKWebView class], @selector(setNavigationDelegate:));
	Method my_Method = class_getInstanceMethod([WKWebView class], @selector(JSE_setDelegate:));
	method_exchangeImplementations(ori_Method, my_Method);
}

- (void)JSE_setDelegate:(id<WKNavigationDelegate>)delegate
{
	[self JSE_setDelegate:delegate];
	WKWebViewJavascriptBridge *bridge = objc_getAssociatedObject(self, wkkeyBridge);
	if (bridge) {
		JSELOG(@"JSEsetDelegate: delegate is changed to %@", delegate);
		[bridge setWebViewDelegate:delegate];
	}
}

- (void)JSE_enableEngine
{
	WKWebViewJavascriptBridge *bridge = objc_getAssociatedObject(self, wkkeyBridge);
	if (bridge) {
		return;
	}
#ifdef DEBUG
	[WKWebViewJavascriptBridge enableLogging];
#endif
	bridge = [WKWebViewJavascriptBridge bridgeForWebView:self];

	// set default handlers
	[bridge registerHandler:@"jse_log" handler:^(id data, WVJBResponseCallback responseCallback) {
		JSELOG(@"JSLOG: %@", data);
	}];
	__weak WKWebViewJavascriptBridge *bridgeWeak = bridge;
	[bridge registerHandler:@"jse_queryall" handler:^(id data, WVJBResponseCallback responseCallback) {
		JSELOG(@"jse_queryall");
		responseCallback([bridgeWeak.Handlers allObjects]);
	}];
	[bridge registerHandler:@"jse_query" handler:^(id data, WVJBResponseCallback responseCallback) {
		JSELOG(@"jse_query: %@", data);
		NSString *flag = [bridgeWeak.Handlers containsObject:data[@"handlername"]]?@"yes":@"no";
		NSDictionary *dict = @{ @"isSupported":flag };
		responseCallback(dict);
	}];
	objc_setAssociatedObject(self, wkkeyBridge, bridge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	JSELOG(@"JS Engine ready. \n default handlers: %@", bridge.Handlers);
}

- (void)JSE_registerNative:(NSString *)handlerName handle:(WKSyncHandler)handler
{
	WKWebViewJavascriptBridge *bridge = objc_getAssociatedObject(self, wkkeyBridge);
	if (!bridge) {
		[self JSE_enableEngine];
		bridge = objc_getAssociatedObject(self, wkkeyBridge);
	}
	[bridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
		JSELOG(@"%@ called: %@", handlerName, data);
		id resposeData = handler(data);
		responseCallback(resposeData);
	}];
}

- (void)JSE_executeJS:(NSString *)handlerName data:(id)data callback:(WKCallback)callback
{
	WKWebViewJavascriptBridge *bridge = objc_getAssociatedObject(self, wkkeyBridge);
	if (!bridge) {
		[self JSE_enableEngine];
		bridge = objc_getAssociatedObject(self, wkkeyBridge);
	}
	[bridge callHandler:handlerName data:data responseCallback:callback];
}
- (void)JSE_registerNative:(NSString *)handlerName withAsyncHandle:(WKAsyncHandler)handler
{
	WKWebViewJavascriptBridge *bridge = objc_getAssociatedObject(self, wkkeyBridge);
	if (!bridge) {
		[self JSE_enableEngine];
		bridge = objc_getAssociatedObject(self, wkkeyBridge);
	}
	
	[bridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
		JSELOG(@"%@ called: %@", handlerName, data);
		WKCallback callBack = ^(id data){
			responseCallback(data);
		};
		handler(data,callBack);
	}];
}

- (void)setWebViewDelegate:(id)delegate
{
	WKWebViewJavascriptBridge* bridge = objc_getAssociatedObject(self, wkkeyBridge);
	if (!bridge) {
		[self JSE_enableEngine];
		bridge = objc_getAssociatedObject(self, wkkeyBridge);
	}
	[bridge setWebViewDelegate:delegate];
}

@end
