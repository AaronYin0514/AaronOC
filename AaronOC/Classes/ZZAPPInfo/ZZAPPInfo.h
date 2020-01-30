//
//  ZZAPPInfo.h
//  GitHubC
//
//  Created by AaronYin on 2019/10/9.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZAPPInfo : NSObject

/// APP名称
@property (class, nonatomic, copy, readonly) NSString *appName;

/// Bundle Identifier
@property (class, nonatomic, copy, readonly) NSString *identifier;

/// APP 版本
@property (class, nonatomic, copy, readonly) NSString *version;

/// APP 构建版本
@property (class, nonatomic, copy, readonly) NSString *build;

/// 设备名称 e.g. "My iPhone"
@property (class, nonatomic, copy, readonly) NSString *deviceName;

/// 设备类型 e.g. @"iPhone", @"iPod touch"
@property (class, nonatomic, copy, readonly) NSString *deviceModel;

/// 系统名称 e.g. @"iOS"
@property (class, nonatomic, copy, readonly) NSString *systemName;

/// 系统版本 e.g. @"4.0"
@property (class, nonatomic, copy, readonly) NSString *systemVersion;

@end

NS_ASSUME_NONNULL_END
