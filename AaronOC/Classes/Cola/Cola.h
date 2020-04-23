//
//  Cola.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/17.
//

#import <Foundation/Foundation.h>

typedef NSString * ColaKey NS_STRING_ENUM;

extern ColaKey const _Nonnull ColaKeyUserInfo;
//extern ColaKey const _Nonnull ColaKeyCompletion;
extern ColaKey const _Nonnull ColaKeyURL;
extern ColaKey const _Nonnull ColaKeyURLParameters;

NS_ASSUME_NONNULL_BEGIN

typedef id __nullable (^ColaHandler)(NSURL *url, NSDictionary *parameters, NSDictionary * __nullable userInfo);

@interface Cola : NSObject

#pragma mark - 初始化

/// 单例
+ (instancetype)cola;

#pragma mark - 属性

@property (nonatomic, strong) dispatch_queue_t registerQueue;

@property (nonatomic, strong) dispatch_queue_t readQueue;

#pragma mark - 注册URL

- (void)registerURL:(NSURL *)URL toHandler:(ColaHandler)handler;

- (void)registerURLPattern:(NSString *)URLPattern toHandler:(ColaHandler)handler;

- (void)deregisterURL:(NSURL *)URL;

#pragma mark - 打开路由

- (BOOL)openURL:(NSURL *)URL object:(void(^)(id __nullable obj))object;

- (BOOL)openURL:(NSURL *)URL withUserInfo:(nullable NSDictionary *)userInfo object:(void(^)(id __nullable obj))object;

#pragma mark - 判断是否存在路由

- (BOOL)canOpenURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
