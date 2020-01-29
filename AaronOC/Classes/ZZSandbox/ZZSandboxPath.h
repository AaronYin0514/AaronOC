//
//  ZZSandbox.h
//  ZZFramework
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 EXComing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZSandboxPath : NSObject

@property (nonatomic, readonly) NSString *appPath;
@property (nonatomic, readonly) NSString *docPath;
@property (nonatomic, readonly) NSString *libPrefPath;
@property (nonatomic, readonly) NSString *libCachePath;
@property (nonatomic, readonly) NSString *tmpPath;

+ (ZZSandboxPath *)sharedInstance;

+ (NSString *)appPath;		// 程序目录，不能存任何东西
+ (NSString *)docPath;		// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libPrefPath;	// 配置目录，配置文件存这里
+ (NSString *)libCachePath;	// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;		// 缓存目录，APP退出后，系统可能会删除这里的内容


+ (BOOL)touch:(NSString *)path;
+ (BOOL)touchFile:(NSString *)file;

@end
