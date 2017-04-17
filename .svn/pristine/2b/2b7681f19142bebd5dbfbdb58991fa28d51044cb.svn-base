//
//  UIWebView+JSEngine.m
//  webtest
//
//  Created by 王学飞 on 14-2-12.
//  Copyright (c) 2014年 王学飞. All rights reserved.
//

#import "UIWebView+JSEngine.h"
#import "WebViewJavascriptBridge.h"
const char *keyBridge = "JSBRIDGE";

@implementation UIWebView (JSEngine)

+ (void)JSE_delegateSwizzling
{
    Method ori_Method =  class_getInstanceMethod([UIWebView class], @selector(setDelegate:));
    Method my_Method = class_getInstanceMethod([UIWebView class], @selector(JSE_setDelegate:));
    method_exchangeImplementations(ori_Method, my_Method);
}

- (void)JSE_setDelegate:(id)delegate
{
    [self JSE_setDelegate:delegate];

    WebViewJavascriptBridge* bridge = objc_getAssociatedObject(self, keyBridge);
    if (bridge) {
        JSELOG(@"JSEsetDelegate: delegate is changed to %@", delegate);
        [bridge setWebViewDelegate:delegate];
        return;
    }
}

- (void)JSE_enableEngine
{
    WebViewJavascriptBridge* bridge = objc_getAssociatedObject(self, keyBridge);
    if (bridge) {
        // already enabled, do nothing
        return;
    }
    
#ifdef DEBUG
    [WebViewJavascriptBridge enableLogging];
#endif
    
	bridge = [WebViewJavascriptBridge bridgeForWebView:self];
	NSLog(@"%@",self.delegate);
    // set default handlers
    [bridge registerHandler:@"jse_log" handler:^(id data, WVJBResponseCallback responseCallback) {
        JSELOG(@"JSLOG: %@", data);
    }];
    
    __weak WebViewJavascriptBridge *bridgeWeak = bridge;
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

    objc_setAssociatedObject(self, keyBridge, bridge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    JSELOG(@"JS Engine ready. \n default handlers: %@", bridge.Handlers);
}

- (void)JSE_registerNative:(NSString*)handlerName handle:(SyncHandler)handler
{
    WebViewJavascriptBridge* bridge = objc_getAssociatedObject(self, keyBridge);
    if (!bridge) {
        [self JSE_enableEngine];
        bridge = objc_getAssociatedObject(self, keyBridge);
    }
    
    [bridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
        JSELOG(@"%@ called: %@", handlerName, data);
        id resposeData = handler(data);
        responseCallback(resposeData);
    }];
}

- (void)JSE_executeJS:(NSString*)handlerName data:(id)data callback:(Callback)callback
{
    WebViewJavascriptBridge* bridge = objc_getAssociatedObject(self, keyBridge);
    if (!bridge) {
        [self JSE_enableEngine];
        bridge = objc_getAssociatedObject(self, keyBridge);
    }
    
    [bridge callHandler:handlerName data:data responseCallback:callback];
}

- (void)setWebViewDelegate:(id)delegate
{
	WebViewJavascriptBridge* bridge = objc_getAssociatedObject(self, keyBridge);
	if (!bridge) {
		[self JSE_enableEngine];
		bridge = objc_getAssociatedObject(self, keyBridge);
	}
	[bridge setWebViewDelegate:delegate];
}

@end
