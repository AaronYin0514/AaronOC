//
//  ZZNavigator.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/14.
//

#import <UIKit/UIKit.h>

typedef NSString * ZZNavigatorKey NS_STRING_ENUM;
typedef NSString * ZZNavigatorMethodValueKey;

extern ZZNavigatorKey const _Nonnull ZZNavigatorBodyKey;
extern ZZNavigatorKey const _Nonnull ZZNavigatorMethodKey;
extern ZZNavigatorKey const _Nonnull ZZNavigatorAnimationKey;
extern ZZNavigatorKey const _Nonnull ZZNavigatorFromKey;
extern ZZNavigatorKey const _Nonnull ZZNavigatorWrapKey;

extern ZZNavigatorMethodValueKey const _Nonnull ZZNavigatorMethodValuePush;
extern ZZNavigatorMethodValueKey const _Nonnull ZZNavigatorMethodValuePressent;
extern ZZNavigatorMethodValueKey const _Nonnull ZZNavigatorMethodValueShowDetail;

typedef UIViewController * _Nullable (^ZZNavigatorControllerFactory)(NSString * __nonnull URL, NSDictionary * __nonnull parameters, id _Nullable body);

typedef id _Nullable (^ZZNavigatorObjectFactory)(NSString * __nonnull URL, NSDictionary * __nonnull parameters, id _Nullable body);

NS_ASSUME_NONNULL_BEGIN

@interface ZZNavigator : NSObject

+ (void)registerURLPattern:(NSString *)URLPattern controllerFactory:(ZZNavigatorControllerFactory)factory;

+ (void)registerURLPattern:(NSString *)URLPattern toObjectFactory:(ZZNavigatorObjectFactory)factory;

+ (void)openURL:(NSString *)URL method:(ZZNavigatorMethodValueKey)method body:(id)body;

@end

NS_ASSUME_NONNULL_END
