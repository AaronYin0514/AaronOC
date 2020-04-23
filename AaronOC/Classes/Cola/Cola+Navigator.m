//
//  Cola+Navigator.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/18.
//

#import "Cola+Navigator.h"
#import "UIViewController+TopMost.h"

@implementation Cola (Navigator)

- (void)registerURL:(NSURL *)URL navigatorHandler:(NavigatorFactory)handler {
    if (!URL || !handler) { return; }
    [self registerURL:URL toHandler:handler];
}

- (void)registerURLPattern:(NSString *)URLPattern navigatorHandler:(NavigatorFactory)handler {
    NSURL *url = [NSURL URLWithString:URLPattern];
    [self registerURL:url navigatorHandler:handler];
}

- (void)pushURL:(NSURL *)URL {
    [self pushURL:URL withUserInfo:nil];
}

- (void)pushURL:(NSURL *)URL withUserInfo:(NSDictionary *)userInfo {
    [self pushURL:URL withUserInfo:userInfo from:nil animated:YES];
}

- (void)pushURL:(NSURL *)URL withUserInfo:(NSDictionary *)userInfo from:(UINavigationController *)fromNavigationController animated:(BOOL)animated {
    __block UIViewController *controller;
    BOOL hasURL = [self openURL:URL withUserInfo:userInfo object:^(id obj) {
        controller = obj;
    }];
    if (!hasURL || ![controller isKindOfClass:[UIViewController class]]) { return; }
    UINavigationController *navigationController = fromNavigationController ?: [UIViewController topMostViewController].navigationController;
    [navigationController pushViewController:controller animated:animated];
}

- (void)presentURL:(NSURL *)URL completion:(void (^)(void))completion {
    [self presentURL:URL withUserInfo:nil completion:completion];
}

- (void)presentURL:(NSURL *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(void))completion {
    [self presentURL:URL withUserInfo:userInfo from:nil wrap:nil animated:YES completion:completion];
}

- (void)presentURL:(NSURL *)URL withUserInfo:(NSDictionary *)userInfo from:(UIViewController *)fromViewController wrap:(Class)wrap animated:(BOOL)flag completion:(void (^)(void))completion {
    [self presentURL:URL withUserInfo:userInfo from:fromViewController wrap:wrap animated:flag willPresent:nil completion:completion];
}

- (void)presentURL:(NSURL *)URL withUserInfo:(nullable NSDictionary *)userInfo from:(nullable UIViewController *)fromViewController wrap:(nullable Class)wrap animated:(BOOL)flag willPresent:(BOOL (^ __nullable)(UIViewController *controller))will completion:(void (^ __nullable)(void))completion {
    __block UIViewController *controller;
    BOOL hasURL = [self openURL:URL withUserInfo:userInfo object:^(id obj) {
        controller = obj;
    }];
    if (!hasURL || ![controller isKindOfClass:[UIViewController class]]) { return; }
    UIViewController *presentedViewController = fromViewController ?: [UIViewController topMostViewController];
    if (will) {
        BOOL present = will(controller);
        if (!present) {
            return;
        }
    }
    if (wrap && [[[wrap alloc] init] isKindOfClass:[UINavigationController class]] && ![controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = [[wrap alloc] initWithRootViewController:controller];
        [presentedViewController presentViewController:navigationController animated:flag completion:completion];
    } else {
        [presentedViewController presentViewController:controller animated:flag completion:completion];
    }
}

- (void)showDetailURL:(NSURL *)URL {
    [self showDetailURL:URL withUserInfo:nil];
}

- (void)showDetailURL:(NSURL *)URL withUserInfo:(NSDictionary *)userInfo {
    [self showDetailURL:URL withUserInfo:userInfo from:nil wrap:nil sender:nil];
}

- (void)showDetailURL:(NSURL *)URL withUserInfo:(NSDictionary *)userInfo from:(UISplitViewController *)fromSplitViewController wrap:(Class)wrap sender:(id)sender {
    __block UIViewController *controller;
    BOOL hasURL = [self openURL:URL withUserInfo:userInfo object:^(id obj) {
        controller = obj;
    }];
    if (!hasURL || ![controller isKindOfClass:[UIViewController class]]) { return; }
    UISplitViewController *splitViewController = fromSplitViewController ?: [UIViewController topMostViewController].splitViewController;
    if (wrap && [[[wrap alloc] init] isKindOfClass:[UINavigationController class]] && ![controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = [[wrap alloc] initWithRootViewController:controller];
        [splitViewController showDetailViewController:navigationController sender:sender];
    } else {
        [splitViewController showDetailViewController:controller sender:sender];
    }
}


@end
