//
//  Cola+Navigator.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/18.
//

#import "Cola.h"

typedef UIViewController * __nullable (^NavigatorFactory)(NSURL * __nonnull URL, NSDictionary * __nonnull parameters, NSDictionary * __nullable userInfo);

NS_ASSUME_NONNULL_BEGIN

@interface Cola (Navigator)

#pragma mark - 注册

- (void)registerURL:(NSURL *)URL navigatorHandler:(NavigatorFactory)handler;

- (void)registerURLPattern:(NSString *)URLPattern navigatorHandler:(NavigatorFactory)handler;

#pragma mark - Push

- (void)pushURL:(NSURL *)URL;

- (void)pushURL:(NSURL *)URL withUserInfo:(nullable NSDictionary *)userInfo;

- (void)pushURL:(NSURL *)URL withUserInfo:(nullable NSDictionary *)userInfo from:(nullable UINavigationController *)fromNavigationController animated:(BOOL)animated;

#pragma mark - Present

- (void)presentURL:(NSURL *)URL completion:(void (^)(void))completion;

- (void)presentURL:(NSURL *)URL withUserInfo:(nullable NSDictionary *)userInfo completion:(void (^ __nullable)(void))completion;

- (void)presentURL:(NSURL *)URL withUserInfo:(nullable NSDictionary *)userInfo from:(nullable UIViewController *)fromViewController wrap:(nullable Class)wrap animated:(BOOL)flag completion:(void (^ __nullable)(void))completion;

#pragma mark - Show Detail

- (void)showDetailURL:(NSURL *)URL;

- (void)showDetailURL:(NSURL *)URL withUserInfo:(nullable NSDictionary *)userInfo;

- (void)showDetailURL:(NSURL *)URL withUserInfo:(nullable NSDictionary *)userInfo from:(nullable UISplitViewController *)fromSplitViewController wrap:(nullable Class)wrap sender:(nullable id)sender;

@end

NS_ASSUME_NONNULL_END
