//
//  ZZMigration.h
//  ZZFramework
//
//  Created by Aaron on 16/6/1.
//  Copyright © 2016年 EXComing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZZExecutionBlock)(void);

@interface ZZMigration : NSObject
/**
*  指定版本，调用一次
*
*  @param version        指定的版本，例如: @"1.0"
*  @param migrationBlock
*/
+ (void)migrateToVersion:(NSString *)version block:(ZZExecutionBlock)migrationBlock;
/**
 *  指定构建版本，调用一次
 *
 *  @param build          指定的构建版本，例如: @"1.0"
 *  @param migrationBlock
 */
+ (void)migrateToBuild:(NSString *)build block:(ZZExecutionBlock)migrationBlock;
/**
 *  版本每次更新时都调用
 *
 *  @param updateBlock
 */
+ (void)applicationUpdateBlock:(ZZExecutionBlock)updateBlock;
/**
 *  构建版本每次更新时调用
 *
 *  @param updateBlock
 */
+ (void)buildNumberUpdateBlock:(ZZExecutionBlock)updateBlock;
/**
 *  重置
 */
+ (void)reset;
/// APP版本号
+ (NSString *)appVersion;
/// APP构建版本号
+ (NSString *)appBuild;

@end
