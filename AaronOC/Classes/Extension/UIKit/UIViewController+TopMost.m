//
//  UIViewController+TopMost.m
//  AaronOC
//
//  Created by AaronYin on 2020/3/30.
//

#import "UIViewController+TopMost.h"

UITopMostControllerKey const UITopMostControllerKeySplitIndex = @"UITopMostControllerKeySplitIndex";

UITopMostControllerKey const UITopMostControllerKeyFromController = @"UITopMostControllerKeyFromController";

@implementation UIViewController (TopMost)

+ (UIViewController *)topMostViewControllerWithUserInfo:(NSDictionary<NSString *, id> *)userInfo {
    UIViewController *rootViewController;
    UIViewController *fromController = userInfo[UITopMostControllerKeyFromController];
    if (fromController && [fromController isKindOfClass:[UIViewController class]]) {
        rootViewController = fromController;
    } else {
        NSArray<UIWindow *> *windows = UIApplication.sharedApplication.windows;
        for (UIWindow *window in windows) {
            if (window.rootViewController != nil && window.isKeyWindow) {
                rootViewController = window.rootViewController;
                break;
            }
        }
    }
    return [self topMostForViewController:rootViewController userInfo:userInfo];
}

+ (UIViewController *)topMostForViewController:(UIViewController *)controller userInfo:(NSDictionary<NSString *, id> *)userInfo {
    if ([controller isKindOfClass:[UISplitViewController class]]) {
        NSInteger index = -1;
        if (userInfo && userInfo[UITopMostControllerKeySplitIndex]) {
            index = [userInfo[UITopMostControllerKeySplitIndex] integerValue];
        }
        UIViewController *controller;
        if (index >= 0 && index < ((UISplitViewController *)controller).viewControllers.count) {
            controller = ((UISplitViewController *)controller).viewControllers[index];
        } else {
            controller = ((UISplitViewController *)controller).viewControllers.lastObject;
        }
        return [self topMostForViewController:controller userInfo:userInfo];
    }
    if (controller.presentedViewController != nil) {
        return [self topMostForViewController:controller.presentedViewController userInfo:userInfo];
    }
    if ([controller isKindOfClass:[UITabBarController class]]) {
        if (((UITabBarController *)controller).selectedViewController != nil) {
            return [self topMostForViewController:((UITabBarController *)controller).selectedViewController userInfo:userInfo];
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)controller).visibleViewController != nil) {
            return [self topMostForViewController:((UINavigationController *)controller).visibleViewController userInfo:userInfo];
        }
    }
    if ([controller isKindOfClass:[UIPageViewController class]]) {
        if (((UIPageViewController *)controller).viewControllers.count == 1) {
            return [self topMostForViewController:((UIPageViewController *)controller).viewControllers.firstObject userInfo:userInfo];
        }
    }
    for (UIView *subview in controller.view.subviews) {
        if ([subview.nextResponder isKindOfClass:[UIViewController class]]) {
            return [self topMostForViewController:(UIViewController *)subview.nextResponder userInfo:userInfo];
        }
    }
    return controller;
}


@end
