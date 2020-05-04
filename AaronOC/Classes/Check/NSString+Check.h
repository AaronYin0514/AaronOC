//
//  NSString+Check.h
//  AaronOC
//
//  Created by AaronYin on 2020/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Check)

/// 邮箱格式验证
- (BOOL)isEmail;

/// 手机号码（中国）格式验证
- (BOOL)isPhoneNumber;

/// 手机号码虚拟号段格式验证
- (BOOL)isVirtualPhoneNumber;

/// 生份证格式验证
- (BOOL)isIdentityCard;

/// 4位验证码格式验证
- (BOOL)is4DigitVerificationCode;

/// 6位验证码格式验证
- (BOOL)is6DigitVerificationCode;

/// 检查字符串格式
/// @param regex 正则表达式
- (BOOL)checkFormatByRegex:(NSString *)regex;

@end

NS_ASSUME_NONNULL_END
