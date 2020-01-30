//
//  ZZMigration.m
//  ZZFramework
//
//  Created by Aaron on 16/6/1.
//  Copyright © 2016年 EXComing. All rights reserved.
//

#import "ZZMigration.h"

static NSString * const ZZMigrationLastVersionKey      = @"ZZMigration.lastMigrationVersion";
static NSString * const ZZMigrationLastAppVersionKey   = @"ZZMigration.lastAppVersion";

static NSString * const ZZMigrationLastBuildKey      = @"ZZMigration.lastMigrationBuild";
static NSString * const ZZMigrationLastAppBuildKey   = @"ZZMigration.lastAppBuild";

@implementation ZZMigration

+ (void)migrateToVersion:(NSString *)version block:(ZZExecutionBlock)migrationBlock {
    // version > lastMigrationVersion && version <= appVersion
    if ([version compare:[self lastMigrationVersion] options:NSNumericSearch] == NSOrderedDescending &&
        [version compare:[self appVersion] options:NSNumericSearch] != NSOrderedDescending) {
        migrationBlock();
#if DEBUG
        NSLog(@"MTMigration: Running migration for version %@", version);
#endif
        [self setLastMigrationVersion:version];
    }
}


+ (void)migrateToBuild:(NSString *)build block:(ZZExecutionBlock)migrationBlock {
    // build > lastMigrationBuild && build <= appVersion
    if ([build compare:[self lastMigrationBuild] options:NSNumericSearch] == NSOrderedDescending &&
        [build compare:[self appBuild] options:NSNumericSearch] != NSOrderedDescending) {
        migrationBlock();
#if DEBUG
        NSLog(@"MTMigration: Running migration for build %@", build);
#endif
        [self setLastMigrationBuild:build];
    }
}


+ (void)applicationUpdateBlock:(ZZExecutionBlock)updateBlock {
    if (![[self lastAppVersion] isEqualToString:[self appVersion]]) {
        updateBlock();
#if DEBUG
        NSLog(@"MTMigration: Running update Block for version %@", [self appVersion]);
#endif
        [self setLastAppVersion:[self appVersion]];
    }
}


+ (void)buildNumberUpdateBlock:(ZZExecutionBlock)updateBlock {
    if (![[self lastAppBuild] isEqualToString:[self appBuild]]) {
        updateBlock();
#if DEBUG
        NSLog(@"MTMigration: Running update Block for build %@", [self appBuild]);
#endif
        [self setLastAppBuild:[self appBuild]];
    }
}


+ (void)reset {
    [self setLastMigrationVersion:nil];
    [self setLastAppVersion:nil];
    [self setLastMigrationBuild:nil];
    [self setLastAppBuild:nil];
}


+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}


+ (NSString *)appBuild {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}


+ (void)setLastMigrationVersion:(NSString *)version {
    [[NSUserDefaults standardUserDefaults] setValue:version forKey:ZZMigrationLastVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void)setLastMigrationBuild:(NSString *)build {
    [[NSUserDefaults standardUserDefaults] setValue:build forKey:ZZMigrationLastBuildKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)lastMigrationVersion {
    NSString *res = [[NSUserDefaults standardUserDefaults] valueForKey:ZZMigrationLastVersionKey];
    return (res ? res : @"");
}


+ (NSString *)lastMigrationBuild {
    NSString *res = [[NSUserDefaults standardUserDefaults] valueForKey:ZZMigrationLastBuildKey];
    return (res ? res : @"");
}


+ (void)setLastAppVersion:(NSString *)version {
    [[NSUserDefaults standardUserDefaults] setValue:version forKey:ZZMigrationLastAppVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void)setLastAppBuild:(NSString *)build {
    [[NSUserDefaults standardUserDefaults] setValue:build forKey:ZZMigrationLastAppBuildKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)lastAppVersion {
    NSString *res = [[NSUserDefaults standardUserDefaults] valueForKey:ZZMigrationLastAppVersionKey];
    return (res ? res : @"");
}


+ (NSString *)lastAppBuild {
    NSString *res = [[NSUserDefaults standardUserDefaults] valueForKey:ZZMigrationLastAppBuildKey];
    return (res ? res : @"");
}


@end
