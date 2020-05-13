//
//  WKWebViewController.m
//  AaronOC
//
//  Created by AaronYin on 2020/5/13.
//

#import "WKWebViewController.h"
#import "AnimationButton.h"
#import "GHDevice.h"

@interface WebViewBarButton : AnimationButton

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImage *disabledImage;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image disabledImage:(UIImage *)disabledImage;

@end

@interface WebViewBar : UIView

@property (nonatomic, strong) WebViewBarButton *backButton;

@property (nonatomic, strong) WebViewBarButton *forwardButton;

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;

@end

@interface WKWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WebViewBar *bar;

@end

@implementation WKWebViewController

- (instancetype)init {
    if (self = [super init]) {
        self.forbidWebViewScale = YES;
        self.defaultProgressValue = 0.1;
    }
    return self;
}

- (void)setDefaultProgressValue:(CGFloat)defaultProgressValue {
    if (defaultProgressValue < 0) {
        _defaultProgressValue = 0.0;
    } else if (defaultProgressValue >= 1) {
        _defaultProgressValue = 0.1;
    } else {
        _defaultProgressValue = defaultProgressValue;
    }
}

#pragma mark - Life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.progressView setProgress:self.defaultProgressValue animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
    self.progressView.frame = CGRectMake(0, [GHDevice defaultDevice].navigationBarAddStatusBarHeight, CGRectGetWidth(self.view.bounds), 2);
    self.bar.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 44 - [GHDevice defaultDevice].bottomSafeHeight, CGRectGetWidth(self.view.bounds), 44 + [GHDevice defaultDevice].bottomSafeHeight);
}

#pragma mark - Action

- (void)backAction:(UIButton *)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        [self checkBackAndForwardButtonEnabled];
    }
}

- (void)forwardAction:(UIButton *)sender {
    if (self.webView.canGoForward) {
        [self.webView goForward];
        [self checkBackAndForwardButtonEnabled];
    }
}

#pragma mark - Web View

- (void)loadRequestWithURLString:(NSString *)URLString {
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

- (void)loadRequest:(NSURLRequest *)request {
    [self.webView loadRequest:request];
}

- (void)loadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL {
    [self.webView loadFileURL:URL allowingReadAccessToURL:readAccessURL];
}

- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
    [self.webView loadHTMLString:string baseURL:baseURL];
}

- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType characterEncodingName:(NSString *)characterEncodingName baseURL:(NSURL *)baseURL {
    [self.webView loadData:data MIMEType:MIMEType characterEncodingName:characterEncodingName baseURL:baseURL];
}

#pragma mark - Observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        NSLog(@"网页加载进度 = %f", self.webView.estimatedProgress);
        if (self.webView.estimatedProgress > self.defaultProgressValue) {
            self.progressView.progress = self.webView.estimatedProgress;
        }
        if (self.webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s: URL: %@", __func__, webView.URL.absoluteString);
    if (self.didStartProvisionalBlock) {
        self.didStartProvisionalBlock(webView, navigation);
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s: URL: %@", __func__, webView.URL.absoluteString);
    if (self.didCommitBlock) {
        self.didCommitBlock(webView, navigation);
    }
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s: URL: %@", __func__, webView.URL.absoluteString);
    if (self.didReceiveServerRedirectForProvisionalBlock) {
        self.didReceiveServerRedirectForProvisionalBlock(webView, navigation);
    }
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s: URL: %@", __func__, webView.URL.absoluteString);
    [self checkBackAndForwardButtonEnabled];
    if (self.didFailProvisionalBlock) {
        self.didFailProvisionalBlock(webView, navigation, error);
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s: URL: %@", __func__, webView.URL.absoluteString);
    [self checkBackAndForwardButtonEnabled];
    if (self.didFailBlock) {
        self.didFailBlock(webView, navigation, error);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%s: URL: %@", __func__, webView.URL.absoluteString);
    if (self.forbidWebViewScale) {
        NSString *injectionJSString = @"var script = document.createElement('meta');"
        "script.name = 'viewport';"
        "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
        "document.getElementsByTagName('head')[0].appendChild(script);";
        [webView evaluateJavaScript:injectionJSString completionHandler:nil];
    }
    [self checkBackAndForwardButtonEnabled];
    if (self.didFinishBlock) {
        self.didFinishBlock(webView, navigation);
    }
}

#pragma mark - UI

- (void)setupSubviews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.bar];
}

- (UIProgressView *)progressView {
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 2)];
        if (@available(iOS 13.0, *)) {
            _progressView.tintColor = [UIColor linkColor];
        } else {
            _progressView.tintColor = [UIColor blueColor];
        }
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (WebViewBar *)bar {
    if (!_bar) {
        _bar = [[WebViewBar alloc] initWithFrame:CGRectZero];
        [_bar.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bar.forwardButton addTarget:self action:@selector(forwardAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bar;
}

#pragma mark - Utils

- (void)checkBackAndForwardButtonEnabled {
    self.bar.backButton.enabled = self.webView.canGoBack;
    self.bar.forwardButton.enabled = self.webView.canGoForward;
}

@end

@implementation WebViewBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.visualEffectView];
        [self addSubview:self.backButton];
        [self addSubview:self.forwardButton];
        self.backButton.enabled = NO;
        self.forwardButton.enabled = NO;
//        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(2);
//            make.centerX.equalTo(self.mas_centerX).offset(-60);
//            make.width.mas_equalTo(40);
//            make.height.mas_equalTo(40);
//        }];
//        [self.forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(2);
//            make.centerX.equalTo(self.mas_centerX).offset(60);
//            make.width.mas_equalTo(40);
//            make.height.mas_equalTo(40);
//        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.visualEffectView.frame = self.bounds;
}

- (WebViewBarButton *)backButton {
    if (!_backButton) {
        _backButton = [[WebViewBarButton alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"web_goback"] disabledImage:[UIImage imageNamed:@"web_goback_disable"]];
        
    }
    return _backButton;
}

- (WebViewBarButton *)forwardButton {
    if (!_forwardButton) {
        _forwardButton = [[WebViewBarButton alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"web_goforward"] disabledImage:[UIImage imageNamed:@"web_goforward_disable"]];
    }
    return _forwardButton;
}

- (UIVisualEffectView *)visualEffectView {
    if (!_visualEffectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
        _visualEffectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    }
    return _visualEffectView;
}

@end

@implementation WebViewBarButton

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image disabledImage:(UIImage *)disabledImage {
    if (self = [super initWithFrame:frame]) {
        self.image = image;
        self.disabledImage = disabledImage;
        [self setImage:self.image forState:UIControlStateNormal];
        [self setImage:self.image forState:UIControlStateHighlighted];
        [self setImage:disabledImage forState:UIControlStateDisabled];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        [self setImage:self.image forState:UIControlStateNormal];
        [self setImage:self.image forState:UIControlStateHighlighted];
        [self setImage:self.disabledImage forState:UIControlStateDisabled];
    } else {
        [self setImage:self.image forState:UIControlStateNormal];
        [self setImage:self.disabledImage forState:UIControlStateHighlighted];
        [self setImage:self.disabledImage forState:UIControlStateDisabled];
    }
}

@end
