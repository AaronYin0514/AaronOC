//
//  SafariViewController.h
//  AaronOC
//
//  Created by AaronYin on 2020/5/14.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafariViewController : UIViewController

@property (nonatomic, strong, readonly) WKWebView *topWebView;

- (instancetype)initWithURL:(NSURL *)URL;


@end

NS_ASSUME_NONNULL_END
