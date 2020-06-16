//
//  UIViewController+TopMost.h
//  AaronOC
//
//  Created by AaronYin on 2020/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * UITopMostControllerKey;
/// UISplitViewController类型，控制器Index，值为NSNumber。不能解决多个问题
FOUNDATION_EXPORT UITopMostControllerKey const UITopMostControllerKeySplitIndex;
/// 从某个控制器计算最顶部控制器，值为UIViewController
FOUNDATION_EXPORT UITopMostControllerKey const UITopMostControllerKeyFromController;

@interface UIViewController (TopMost)

+ (UIViewController * _Nullable)topMostViewControllerWithUserInfo:(NSDictionary<NSString *, id> * _Nullable)userInfo;

+ (UIViewController * _Nullable)topMostForViewController:(UIViewController *)controller userInfo:(NSDictionary<NSString *, id> * _Nullable)userInfo;

@end

NS_ASSUME_NONNULL_END
