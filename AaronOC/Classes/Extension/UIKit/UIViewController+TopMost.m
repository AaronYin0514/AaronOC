//
//  UIViewController+TopMost.m
//  AaronOC
//
//  Created by AaronYin on 2020/3/30.
//

#import "UIViewController+TopMost.h"

@implementation UIViewController (TopMost)

+ (UIViewController *)topMostViewController {
    NSArray<UIWindow *> *windows = UIApplication.sharedApplication.windows;
    UIViewController *rootViewController;
    for (UIWindow *window in windows) {
        if (window.rootViewController != nil && window.isKeyWindow) {
            rootViewController = window.rootViewController;
            break;
        }
    }
    return [self topMostForViewController:rootViewController];
}

+ (UIViewController *)topMostForViewController:(UIViewController *)controller {
    if (controller.presentedViewController != nil) {
        return [self topMostForViewController:controller.presentedViewController];
    }
    if ([controller isKindOfClass:[UITabBarController class]]) {
        if (((UITabBarController *)controller).selectedViewController != nil) {
            return [self topMostForViewController:((UITabBarController *)controller).selectedViewController];
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)controller).visibleViewController != nil) {
            return [self topMostForViewController:((UINavigationController *)controller).visibleViewController];
        }
    }
    if ([controller isKindOfClass:[UIPageViewController class]]) {
        if (((UIPageViewController *)controller).viewControllers.count == 1) {
            return [self topMostForViewController:controller.presentedViewController];
        }
    }
    for (UIView *subview in controller.view.subviews) {
        if ([subview.nextResponder isKindOfClass:[UIViewController class]]) {
            return [self topMostForViewController:(UIViewController *)subview.nextResponder];
        }
    }
    return controller;
}


@end
