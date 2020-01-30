//
//  NSString+ZZExtras.h
//  FutureWindow
//
//  Created by Aaron on 16/8/12.
//  Copyright © 2016年 Newtouch. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZZExtras)
/**
 *  判断是否是空字符串
 */
+(BOOL)isEmpty:(nullable NSString *)string;

/**
 *  写入系统偏好
 *
 *  @param key 写入键值
 */
-(void)saveToNSDefaultsWithKey:(nullable NSString *)key;

/**
 *  获取MIMEType
 */
- (NSString *)MIMEType;

/**
 *  获取指定文件的MIMEType
 *
 *  @param extension 文件后缀
 */
+ (NSString *)MIMETypeForExtension:(NSString *)extension;
/**
 *  判断字符串是否包含中文
 */
-(BOOL)isChinese;

@end

NS_ASSUME_NONNULL_END
