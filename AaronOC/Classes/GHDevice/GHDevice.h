//
//  GHDevice.h
//  GitHubC
//
//  Created by AaronYin on 2019/8/2.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GHAppleDeviceTypeIPhone5,
    GHAppleDeviceTypeIPhone6,
    GHAppleDeviceTypeIPhone7,
} GHAppleDeviceType;

@interface GHDevice : NSObject

+ (GHDevice *)defaultDevice;

#pragma mark - 设备
@property (nonatomic, assign, readonly) BOOL isIPhone;

@property (nonatomic, assign, readonly) BOOL isIPad;

@property (nonatomic, assign, readonly) BOOL isIPod;

@property (nonatomic, assign, readonly) BOOL isSimuLator;

#pragma mark - 设备尺寸

@property (nonatomic, assign, readonly) CGFloat screenWidth;

@property (nonatomic, assign, readonly) CGFloat screenHeight;

@property (nonatomic, assign, readonly) BOOL isFullScreen;

@property (nonatomic, assign, readonly) CGFloat statusBarHeight;

@property (nonatomic, assign, readonly) CGFloat navigationBarHeight;

@property (nonatomic, assign, readonly) CGFloat navigationBarAddStatusBarHeight;

@property (nonatomic, assign, readonly) CGFloat bottomSafeHeight;

@property (nonatomic, assign, readonly) CGFloat tabBarHeight;

@end

NS_ASSUME_NONNULL_END
