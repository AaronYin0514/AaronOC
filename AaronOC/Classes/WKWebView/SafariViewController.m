//
//  SafariViewController.m
//  AaronOC
//
//  Created by AaronYin on 2020/5/14.
//

#import "SafariViewController.h"

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

@interface SafariViewController ()

@property (nonatomic, strong) NSMutableArray<WKWebView *> *webViews;

@end

@implementation SafariViewController

#pragma mark - Init

- (instancetype)initWithURL:(NSURL *)URL {
    if (self = [super init]) {
        self.webViews = [NSMutableArray array];
        [self addWebViewWithURL:URL animated:NO];
    }
    return self;
}

#pragma mark - Life

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 添加 Web View

- (void)addWebViewWithURL:(NSURL *)URL animated:(BOOL)animated {
    if (!URL) { return; }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    [self addWebViewWithURLRequest:request animated:animated];
}

- (void)addWebViewWithURLRequest:(NSURLRequest *)request animated:(BOOL)animated {
    if (!request) { return; }
    WKWebView *webView = [[WKWebView alloc] initWithFrame:SCREEN_BOUNDS];
    webView.tag = self.webViews.count;
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

@end
