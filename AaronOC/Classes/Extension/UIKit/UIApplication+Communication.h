//
//  UIApplication+Communication.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Communication)

+ (void)makeATelephoneCallWithNumber:(NSString *)number;

+ (void)sendMessageWithMessage:(NSString *)message;

+ (void)sendEmailWithEmailAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
