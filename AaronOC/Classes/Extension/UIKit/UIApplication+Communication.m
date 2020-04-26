//
//  UIApplication+Communication.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/26.
//

#import "UIApplication+Communication.h"

@implementation UIApplication (Communication)

+ (void)makeATelephoneCallWithNumber:(NSString *)number {
    NSString *telNumber = [NSString stringWithFormat:@"tel://%@", number];
    NSURL *url = [NSURL URLWithString:telNumber];
    [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:nil];
}

+ (void)sendMessageWithMessage:(NSString *)message {
    NSString *urlStr = [NSString stringWithFormat:@"sms://%@", message];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:nil];
}

+ (void)sendEmailWithEmailAddress:(NSString *)address {
    NSString *mailStr = [NSString stringWithFormat:@"mailto:%@", address];
    NSURL *url = [NSURL URLWithString:mailStr];
    [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:nil];
}

@end
