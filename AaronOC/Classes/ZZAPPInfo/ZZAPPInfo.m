//
//  ZZAPPInfo.m
//  GitHubC
//
//  Created by AaronYin on 2019/10/9.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "ZZAPPInfo.h"

@implementation ZZAPPInfo

+ (NSString *)appName {
    id value = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleExecutableKey];
    return [NSString stringWithFormat:@"%@", value];
}

+ (NSString *)identifier {
    id value = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    return [NSString stringWithFormat:@"%@", value];
}

+ (NSString *)version {
    id value = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey];
    return [NSString stringWithFormat:@"%@", value];
}

+ (NSString *)build {
    id value = [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey];
    return [NSString stringWithFormat:@"%@", value];
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)deviceModel {
    return [[UIDevice currentDevice] model];
}

+ (NSString *)systemName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

@end
