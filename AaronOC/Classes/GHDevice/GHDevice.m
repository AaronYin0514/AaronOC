//
//  GHDevice.m
//  GitHubC
//
//  Created by AaronYin on 2019/8/2.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "GHDevice.h"

static GHDevice *gh_device = nil;

@interface GHDevice ()

@property (nonatomic, assign, readwrite) BOOL isIPhone;

@property (nonatomic, assign, readwrite) BOOL isIPad;

@property (nonatomic, assign, readwrite) BOOL isIPod;

@property (nonatomic, assign, readwrite) BOOL isSimuLator;

@property (nonatomic, assign, readwrite) CGFloat screenWidth;

@property (nonatomic, assign, readwrite) CGFloat screenHeight;

@property (nonatomic, assign, readwrite) BOOL isFullScreen;

@property (nonatomic, assign, readwrite) CGFloat statusBarHeight;

@property (nonatomic, assign, readwrite) CGFloat navigationBarHeight;

@property (nonatomic, assign, readwrite) CGFloat navigationBarAddStatusBarHeight;

@property (nonatomic, assign, readwrite) CGFloat bottomSafeHeight;

@property (nonatomic, assign, readwrite) CGFloat tabBarHeight;

@end

@implementation GHDevice

+ (GHDevice *)defaultDevice {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gh_device = [[super allocWithZone:NULL] init];
        gh_device.isIPhone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
        gh_device.isIPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
        gh_device.isIPod = ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"]);
        if (TARGET_IPHONE_SIMULATOR) {
            gh_device.isSimuLator = YES;//模拟器
        } else {
            gh_device.isSimuLator = NO;//真机
        }
        gh_device.screenWidth = [UIScreen mainScreen].bounds.size.width;
        gh_device.screenHeight = [UIScreen mainScreen].bounds.size.height;
        gh_device.statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        gh_device.isFullScreen = (gh_device.statusBarHeight > 20);
        gh_device.navigationBarHeight = [UINavigationController new].navigationBar.frame.size.height;
        gh_device.navigationBarAddStatusBarHeight = gh_device.statusBarHeight + gh_device.navigationBarHeight;
        gh_device.bottomSafeHeight = gh_device.isIPad ? (gh_device.isFullScreen ? 15.0 : 0.0) : (gh_device.isFullScreen ? 34.0 : 0.0);
        gh_device.tabBarHeight = [UITabBarController new].tabBar.frame.size.height + gh_device.bottomSafeHeight;
        
    });
    return gh_device;
}

@end
