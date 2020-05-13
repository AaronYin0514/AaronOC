//
//  WKWebViewController.h
//  AaronOC
//
//  Created by AaronYin on 2020/5/13.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewController : UIViewController

/// 禁止Web View缩放，默认为Yes
@property (nonatomic, assign) BOOL forbidWebViewScale;

/// 加载网络是会有一段请求时间，这段时间页面是空白的，显示一个默认进度，提示用户正在加载。默认0.1
@property (nonatomic, assign) CGFloat defaultProgressValue;

- (void)loadRequestWithURLString:(NSString *)URLString;

- (void)loadRequest:(NSURLRequest *)request;

- (void)loadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL API_AVAILABLE(macos(10.11), ios(9.0));

- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;

- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType characterEncodingName:(NSString *)characterEncodingName baseURL:(NSURL *)baseURL API_AVAILABLE(macos(10.11), ios(9.0));

#pragma mark - Delegate

@property (nonatomic, copy) void(^didStartProvisionalBlock)(WKWebView *webView, WKNavigation *navigation);

@property (nonatomic, copy) void(^didCommitBlock)(WKWebView *webView, WKNavigation *navigation);

@property (nonatomic, copy) void(^didReceiveServerRedirectForProvisionalBlock)(WKWebView *webView, WKNavigation *navigation);

@property (nonatomic, copy) void(^didFailProvisionalBlock)(WKWebView *webView, WKNavigation *navigation, NSError *error);

@property (nonatomic, copy) void(^didFailBlock)(WKWebView *webView, WKNavigation *navigation, NSError *error);

@property (nonatomic, copy) void(^didFinishBlock)(WKWebView *webView, WKNavigation *navigation);

@end

NS_ASSUME_NONNULL_END
