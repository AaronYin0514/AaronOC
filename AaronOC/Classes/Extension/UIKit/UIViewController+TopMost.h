//
//  UIViewController+TopMost.h
//  AaronOC
//
//  Created by AaronYin on 2020/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TopMost)

+ (UIViewController *)topMostViewController;

+ (UIViewController *)topMostForViewController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
