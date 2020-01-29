//
//  ZZSandbox.m
//  ZZFramework
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 EXComing. All rights reserved.
//

#import "ZZSandboxPath.h"

@interface ZZSandboxPath ()
{
    NSString *	_appPath;
    NSString *	_docPath;
    NSString *	_libPrefPath;
    NSString *	_libCachePath;
    NSString *	_tmpPath;
}

- (BOOL)touch:(NSString *)path;
- (BOOL)touchFile:(NSString *)path;

@end

@implementation ZZSandboxPath

@dynamic appPath;
@dynamic docPath;
@dynamic libPrefPath;
@dynamic libCachePath;
@dynamic tmpPath;

+ (ZZSandboxPath *)sharedInstance{
    static ZZSandboxPath *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark --methods

+ (NSString *)appPath {
    return [[ZZSandboxPath sharedInstance] appPath];
}

- (NSString *)appPath {
    if (nil == _appPath) {
        NSError * error = nil;
        NSArray * paths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:NSHomeDirectory() error:&error];
        
        for (NSString * path in paths) {
            if ([path hasSuffix:@".app"]) {
                _appPath = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), path];
                break;
            }
        }
    }
    return _appPath;
}

+ (NSString *)docPath {
    return [[ZZSandboxPath sharedInstance] docPath];
}

- (NSString *)docPath {
    if (nil == _docPath) {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _docPath = [paths objectAtIndex:0];
    }
    return _docPath;
}

+ (NSString *)libPrefPath {
    return [[ZZSandboxPath sharedInstance] libPrefPath];
}

- (NSString *)libPrefPath {
    if (nil == _libPrefPath) {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
        
        [self touch:path];
        
        _libPrefPath = path;
    }
    
    return _libPrefPath;
}

+ (NSString *)libCachePath {
    return [[ZZSandboxPath sharedInstance] libCachePath];
}

- (NSString *)libCachePath {
    if (nil == _libCachePath) {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
        [self touch:path];
        _libCachePath = path;
    }
    return _libCachePath;
}

+ (NSString *)tmpPath {
    return [[ZZSandboxPath sharedInstance] tmpPath];
}

- (NSString *)tmpPath {
    if (nil == _tmpPath) {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
        [self touch:path];
        _tmpPath = path;
    }
    return _tmpPath;
}

+ (BOOL)touch:(NSString *)path {
    return [[ZZSandboxPath sharedInstance] touch:path];
}

- (BOOL)touch:(NSString *)path {
    BOOL isDirectory = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory] && !isDirectory) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return YES;
}

+ (BOOL)touchFile:(NSString *)file {
    return [[ZZSandboxPath sharedInstance] touchFile:file];
}

- (BOOL)touchFile:(NSString *)file {
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:file]) {
        return [[NSFileManager defaultManager] createFileAtPath:file contents:[NSData data] attributes:nil];
    }
    return YES;
}

@end
