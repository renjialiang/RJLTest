//
//  RJLWebViewController.m
//  RJLTestPro
//
//  Created by mini on 16/4/6.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#import "RJLWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>
@interface RJLWebViewController () <IMYWebViewDelegate>
@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView	*web;
@end

@implementation RJLWebViewController

- (void)dealloc
{
	NSLog(@"asdfas");
}

- (void)viewWillAppear:(BOOL)animated
{
	
	UIAlertController *promptAlert = [UIAlertController alertControllerWithTitle:@"sdafsadf" message:nil preferredStyle:UIAlertControllerStyleAlert];
	[self presentViewController:promptAlert animated:NO completion:nil];
//    if (0) {
//        
//        if (_bridge) { return; }
//        NSDictionary* dicProperties0 = [NSDictionary dictionaryWithObjectsAndKeys:@"fb436db9d6ed741efc579da92b886b0a",NSHTTPCookieValue,@"jgbsessid",NSHTTPCookieName,@"/",NSHTTPCookiePath,@".10jqka.com.cn",NSHTTPCookieDomain, nil];
//        NSDictionary* dicProperties = [NSDictionary dictionaryWithObjectsAndKeys:@"ifind_e001",NSHTTPCookieValue,@"escapename",NSHTTPCookieName,@"/",NSHTTPCookiePath,@".10jqka.com.cn",NSHTTPCookieDomain, nil];
//        NSDictionary* dicProperties1 = [NSDictionary dictionaryWithObjectsAndKeys:@"4b3c4418a5f1aa72fde69287c68ad75a",NSHTTPCookieValue,@"ticket",NSHTTPCookieName,@"/",NSHTTPCookiePath,@".10jqka.com.cn",NSHTTPCookieDomain, nil];
//        NSDictionary* dicProperties2 = [NSDictionary dictionaryWithObjectsAndKeys:@"ifind_e001",NSHTTPCookieValue,@"u_name",NSHTTPCookieName,@"/",NSHTTPCookiePath,@".10jqka.com.cn",NSHTTPCookieDomain, nil];
//        NSDictionary* dicProperties3 = [NSDictionary dictionaryWithObjectsAndKeys:@"MDppZmluZF9lMDAxOjpOb25lOjUwMDoxMTYxMDUwMDM6NCwxMTExMTExMTExMTExMTExMTExMTExMTEsMDs1LDEsMDs2LDEsMDs3LDExMTExMTExMTExMSwwOzgsMTExMTAxMTExMTAwMTExMTEwMTEwMDAxMTEsMDs5LDExLDA7MTAsMSwwOzExLDEsMDsxMiwxLDA7MTMsMSwwOzE0LDEsMDsxNSwxLDA7MTYsMSwwOzE3LDEsMDsxOCwxLDA7MTksMSwwOzIwLDEsMDsyMSwxLDA7MjIsMSwwOzIzLDEsMDsyNCwxLDA7MjUsMSwwOzI2LDEsMDsyNywxLDA7MjgsMSwwOzI5LDEsMDszMCwxLDA7MzEsMSwwOzMyLDEsMDszMywxMTExMTExMTExMTEsMDszNCwxLDA7MzUsMSwwOzM2LDExMTExMTExMTExMTExMTExMTExMTExMSwwOzM3LDEsMDszOCwxLDA7MzksMSwwOzQwLDEsMDs0MSwxMTExMSwwOzQyLDEwMTExMSwwOzQzLDExMTExMTExMTExMTExMTExMTExMTExMSwwOzQ0LDExMTExLDA7NDUsMTExMTExMTExLDA7NDYsMTExMTExMTExMTExMTExMTExMTExMTExLDA7NDcsMTExMTExMTExMTExMTExLDA7NDgsMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTEsMDs0OSwxMTExMTExMSwwOzUwLDExLDA7NTEsMTExMTExMTExMTExMTExMSwwOzUyLDEsMDs1MywxMTExMTExMTExMTExMTExMTExMTExMTEsMDs1NCwxMTExMTExMTExMTExMTExMTExMTExMTExLDA7NTUsMTExMSwwOzU2LDExLDA7NTcsMTExMTExMTExMTExMTExMTExMTEsMDs1OCwxMTExMTExMTExMTExMTExMSwwOzU5LDEsMDs2MCwxMTExMTExMTExMTExMTExMSwwOzYxLDExLDA7NjIsMTExMTExMTExMTExMTExMTExMTExMTExLDA7NjMsMTExMTExMTExMTExMTExMTExMTExMTExLDA7NjQsMTExMTExMTExMTExMTExMTExMTExMTExLDA7NjUsMTExLDA7NjYsMTExMTExMTExMTExMSwwOzY3LDExMTExMTExMTExMTExMTExMTExMTExMSwwOzY4LDExMTExMTExMTExMTExMTExLDA7NjksMTExMTExMTExMTExMTExMTExMTExMTExLDA7NzAsMSwwOzcxLDExMTExMTExMTExMTExMTExMTExMTExMSwwOzcyLDEsMDs3MywxMTExLDA7NzQsMSwwOzc1LDEsMDs3NiwxMSwwOzc3LDExMTExMSwwOzc4LDEsMDs3OSwxMTExLDA7ODAsMTExMTExMTExMTExMTExMTExMTExMTExLDA7ODEsMTExMTExMTExMTExMTExMTExMTExMTExLDA7ODIsMTExMTExMTExMTExMTExMTExMTExMTExLDA7ODMsMTExMTExMTExMTExMTExMTExMTExMTExLDA7ODUsMTExMTExMTExMTExMTExMTExMTExMTExLDA7ODYsMSwwOzg3LDExMTExMTExMTExMTExMTExMTExMTExMSwwOzg4LDEsMDs4OSwxMTExMTExMTExMTExMTExMTExMCwwOjI3Ojo6MTA2MTA1MDAzOjE0NjAzNTY4MjU6OjoxMzA3NTEwNDYwOjIyNzk3NTow",NSHTTPCookieValue,@"user",NSHTTPCookieName,@"/",NSHTTPCookiePath,@".10jqka.com.cn",NSHTTPCookieDomain, nil];
//        NSDictionary* dicProperties4 = [NSDictionary dictionaryWithObjectsAndKeys:@"106105003",NSHTTPCookieValue,@"userid",NSHTTPCookieName,@"/",NSHTTPCookiePath,@".10jqka.com.cn",NSHTTPCookieDomain, nil];
//        
//        //	NSDictionary* dicProperties = [NSDictionary dictionaryWithObject:@"dbefdeb764f19f0b3566d1142cb96a84" forKey:@"jgbsessid"]; //dictionaryWithObjectsAndKeys:@"1",NSHTTPCookieValue,@"newCount",NSHTTPCookieName,@"/",NSHTTPCookiePath,@".10jqka.com.cn",NSHTTPCookieDomain, nil];
//        NSHTTPCookie* cookie0 = [NSHTTPCookie cookieWithProperties:dicProperties0];
//        
//        NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:dicProperties];
//        NSHTTPCookie* cookie1 = [NSHTTPCookie cookieWithProperties:dicProperties1];
//        
//        NSHTTPCookie* cookie2 = [NSHTTPCookie cookieWithProperties:dicProperties2];
//        
//        NSHTTPCookie* cookie3 = [NSHTTPCookie cookieWithProperties:dicProperties3];
//        NSHTTPCookie* cookie4 = [NSHTTPCookie cookieWithProperties:dicProperties4];
//        
//        
//        NSArray *cookies = [NSArray arrayWithObjects:cookie0, cookie, cookie1, cookie2, cookie3, cookie4,nil];
//        NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://testft.10jqka.com.cn/thsft/iFindService/CellPhone/i-strategy/point-view?postid=62343395"]];
//        [request setValue:[headers objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
//        
//        //	- (instancetype)initWithFrame:(CGRect)frame usingUIWebView:(BOOL)usingUIWebView;
//        
//        //	_web = [[WKWebView alloc]initWithFrame:self.view.bounds];
//        //	self.webView = [[IMYWebView alloc] initWithFrame:self.view.bounds usingUIWebView:YES];
//        self.webView = [[IMYWebView alloc] initWithFrame:self.view.bounds usingUIWebView:YES];
//        
//        [self.view addSubview:_webView];
//        
//        //	[self.view addSubview:_web];
//        if(_webView.usingUIWebView)
//        {
//            self.title = @"ClickRefresh-UIWebView";
//        }
//        else
//        {
//            self.title = @"ClickRefresh-WKWebView";
//        }
//        
//        
//        	[_webView JSE_enableEngine];
//        	//点击评论
//        //	[_webView JSE_setDelegate:self];
//        //	__weak typeof(self) weakSelf = self;
//        	[_webView JSE_registerNative:@"beginComment" handle:(id)^(id data) {
//        		NSLog(@"beginComment");
//        //		return [weakSelf beginCommentHandler:data];
//        	}];
//        	//点击头像跳转到个人中心
//        	[_webView JSE_registerNative:@"userCenter" handle:(id)^(id data) {
//        
//        		NSLog(@"userCenter");
//        		return nil;
//        	}];
//        	[_webView JSE_registerNative:@"shareData" handle:(id)^(id data) {
//        		NSLog(@"shareData");
//        		return nil;
//        
//        //		return [weakSelf shareDataHandler:data];
//        	}];
//        	[_webView JSE_registerNative:@"gotoiStrategy" handle:(id)^(id data) {
//        		NSLog(@"gotoiStrategy");
//        		return nil;
//        
//        //		return [weakSelf gotoiStrategyHandler:data];
//        	}];
//        	[_webView JSE_registerNative:@"threeInOne" handle:(id)^(id data) {
//        		NSLog(@"threeInOne");
//        		return nil;
//        
//        //		return [weakSelf threeInOneHandler:data];
//        	}];
//        	[_webView JSE_registerNative:@"authControl" handle:(id)^(id data) {
//        		NSLog(@"authControl");
//        
//        //		if ([data isKindOfClass:[NSDictionary class]])
//        //		{
//        //			[weakSelf getFollowState:data];
//        //		}
//        		return @"";
//        	}];
//        [_webView loadRequest:request];
//        return;
//    }
	
    self.webView = [[IMYWebView alloc] initWithFrame:self.view.bounds usingUIWebView:NO];
    
    [self.view addSubview:_webView];
	NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
	NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
	NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
	[_webView loadHTMLString:appHtml baseURL:baseURL];
	[_webView JSE_enableEngine];
	[_webView JSE_registerNative:@"testObjcCallback" handle:^(id data, WVJBResponseCallback responseCallback) {
		NSLog(@"1");
//		return "";
//		responseCallback(@"Response from testObjcCallback");
	}];
//	_bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView.realWebView];
//	[WKWebViewJavascriptBridge enableLogging];

//	[_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
//		NSLog(@"testObjcCallback called: %@", data);
//		responseCallback(@"Response from testObjcCallback");
//	}];
	
//	[_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
	
//	[self renderButtons:_webView.realWebView];
////	[self loadExamplePage:_webView.realWebView];
}

- (void)viewDidAppear:(BOOL)animated
{
	
	
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"webViewDidFinishLoad");
}

- (void)renderButtons:(UIWebView*)webView {
	UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
	
	UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
	[callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
	[self.view insertSubview:callbackButton aboveSubview:webView];
	callbackButton.frame = CGRectMake(10, 400, 100, 35);
	callbackButton.titleLabel.font = font;
	
	UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
	[reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
	[self.view insertSubview:reloadButton aboveSubview:webView];
	reloadButton.frame = CGRectMake(110, 400, 100, 35);
	reloadButton.titleLabel.font = font;
}

- (void)callHandler:(id)sender {
	id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
	[_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
		NSLog(@"testJavascriptHandler responded: %@", response);
	}];
}

- (void)loadExamplePage:(UIWebView*)webView {
	NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
	NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
	NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
	[webView loadHTMLString:appHtml baseURL:baseURL];
}

-(BOOL)webView:(IMYWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	return NO;
}

@end
