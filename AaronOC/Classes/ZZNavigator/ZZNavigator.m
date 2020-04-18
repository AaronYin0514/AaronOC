//
//  ZZNavigator.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/14.
//

#import "ZZNavigator.h"
#import "ZZRouter.h"
#import "UIViewController+TopMost.h"

ZZNavigatorKey const ZZNavigatorBodyKey = @"ZZNavigatorBodyKey";
ZZNavigatorKey const ZZNavigatorMethodKey = @"ZZNavigatorMethodKey";
ZZNavigatorKey const ZZNavigatorAnimationKey = @"ZZNavigatorAnimationKey";
ZZNavigatorKey const ZZNavigatorFromKey = @"ZZNavigatorFromKey";
ZZNavigatorKey const ZZNavigatorWrapKey = @"ZZNavigatorWrapKey";

ZZNavigatorMethodValueKey const ZZNavigatorMethodValuePush = @"ZZNavigatorMethodValuePush";
ZZNavigatorMethodValueKey const ZZNavigatorMethodValuePressent = @"ZZNavigatorMethodValuePressent";
ZZNavigatorMethodValueKey const ZZNavigatorMethodValueShowDetail = @"ZZNavigatorMethodValueShowDetail";

@implementation ZZNavigator

+ (void)registerURLPattern:(NSString *)URLPattern controllerFactory:(ZZNavigatorControllerFactory)factory {
    NSAssert([self validateURL:URLPattern], @"URL格式不正确");
    if (!factory) { return; }
    [ZZRouter registerURLPattern:URLPattern toHandler:^(NSDictionary *routerParameters) {
        __block NSString *url;
        __block id body;
        __block NSString *method = ZZNavigatorMethodValuePush;
        __block BOOL animation = YES;
        __block Class wrapClass;
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
        [routerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:ZZRouterParameterURL]) {
                url = obj;
            } else if ([key isEqualToString:ZZRouterParameterUserInfo]) {
                NSDictionary *dict = obj;
                if (dict && [dict isKindOfClass:[NSDictionary class]]) {
                    body = dict[ZZNavigatorBodyKey];
                    if (dict[ZZNavigatorMethodKey]) {
                        method = dict[ZZNavigatorMethodKey];
                    }
                    if (dict[ZZNavigatorAnimationKey]) {
                        animation = [dict[ZZNavigatorAnimationKey] boolValue];
                    }
                    if (dict[ZZNavigatorWrapKey]) {
                        wrapClass = dict[ZZNavigatorWrapKey];
                    }
                }
            } else if (![key isEqualToString:ZZRouterParameterCompletion]) {
                params[key] = obj;
            }
        }];
        if (!url || !params) {
            return;
        }
        UIViewController *controller = factory(url, params, body);
        if (!controller || ![controller isKindOfClass:[UIViewController class]]) {
            return;
        }
        if ([method isEqualToString:ZZNavigatorMethodValuePush]) {
            if ([controller isKindOfClass:[UINavigationController class]]) {
                return;
            }
            UINavigationController *navigarionController;
            navigarionController = routerParameters[ZZNavigatorFromKey];
            if (!navigarionController || ![navigarionController isKindOfClass:[UINavigationController class]]) {
                navigarionController = UIViewController.topMostViewController.navigationController;
            }
            [navigarionController pushViewController:controller animated:animation];
        } else if ([method isEqualToString:ZZNavigatorMethodValuePressent]) {
            UIViewController *fromViewController;
            fromViewController = routerParameters[ZZNavigatorFromKey];
            if (!fromViewController || ![fromViewController isKindOfClass:[UIViewController class]]) {
                fromViewController = UIViewController.topMostViewController;
            }
            if (wrapClass && [[[wrapClass alloc] init] isKindOfClass:[UINavigationController class]] && ![controller isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navigationController = [[wrapClass alloc] initWithRootViewController:controller];
                [fromViewController presentViewController:navigationController animated:animation completion:nil];
            } else {
                [fromViewController presentViewController:controller animated:animation completion:nil];
            }
        } else if ([method isEqualToString:ZZNavigatorMethodValueShowDetail]) {
            UISplitViewController *splitViewController;
            splitViewController = routerParameters[ZZNavigatorFromKey];
            if (!splitViewController || ![splitViewController isKindOfClass:[UISplitViewController class]]) {
                splitViewController = UIViewController.topMostViewController.splitViewController;
            }
            if (wrapClass && [[[wrapClass alloc] init] isKindOfClass:[UINavigationController class]] && ![controller isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navigationController = [[wrapClass alloc] initWithRootViewController:controller];
                [splitViewController showDetailViewController:navigationController sender:nil];
            } else {
                [splitViewController showDetailViewController:controller sender:nil];
            }
        }
    }];
}

+ (void)registerURLPattern:(NSString *)URLPattern toObjectFactory:(ZZNavigatorObjectFactory)factory {
    NSAssert([self validateURL:URLPattern], @"URL格式不正确");
    if (!factory) { return; }
    [ZZRouter registerURLPattern:URLPattern toObjectHandler:^id(NSDictionary *routerParameters) {
        __block NSString *url;
        __block id body;
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
        [routerParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:ZZRouterParameterURL]) {
                url = obj;
            } else if ([key isEqualToString:ZZRouterParameterUserInfo]) {
                NSDictionary *dict = obj;
                if (dict && [dict isKindOfClass:[NSDictionary class]]) {
                    body = dict[ZZNavigatorBodyKey];
                }
            } else if (![key isEqualToString:ZZRouterParameterCompletion]) {
                params[key] = obj;
            }
        }];
        if (!url || !params) {
            return nil;
        }
        return factory(url, params, body);
    }];
}

+ (void)openURL:(NSString *)URL method:(ZZNavigatorMethodValueKey)method body:(id)body {
    NSAssert([self validateURL:URL], @"URL格式不正确");
    if (![ZZRouter canOpenURL:URL]) { return; }
    
}

+ (void)openURL:(NSString *)URL method:(NSString *)method {
    NSAssert([self validateURL:URL], @"URL格式不正确");
    if (![ZZRouter canOpenURL:URL]) { return; }
    [ZZRouter openURL:URL withUserInfo:@{ZZNavigatorMethodKey : method} completion:nil];
}

+ (void)openURL:(NSString *)URL method:(ZZNavigatorMethodValueKey)method body:(id)body from:(UIViewController *)from wrap:(Class)wrap animated:(BOOL)animated {
    NSAssert([self validateURL:URL], @"URL格式不正确");
    NSAssert(!method || method.length <= 0, @"跳转方式不能为空");
    if (![ZZRouter canOpenURL:URL]) { return; }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:5];
    userInfo[ZZNavigatorMethodKey] = method;
    if (body) {
        userInfo[ZZNavigatorBodyKey] = body;
    }
    if (from) {
        userInfo[ZZNavigatorFromKey] = from;
    }
    userInfo[ZZNavigatorAnimationKey] = @(animated);
    [ZZRouter openURL:URL withUserInfo:userInfo completion:nil];
}

+ (id)objectForURL:(NSString *)URL {
    NSAssert([self validateURL:URL], @"URL格式不正确");
    if (![ZZRouter canOpenURL:URL]) { return nil; }
    
    return [ZZRouter objectForURL:URL];
}

+ (BOOL)validateURL:(NSString *)urlString {
    NSString *regex = @"(\\w+)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]";
    NSPredicate *urlPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [urlPre evaluateWithObject:urlString];
}

@end
