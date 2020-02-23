//
//  GHAlgorithm.h
//  GitHubC
//
//  Created by AaronYin on 2019/9/5.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHAlgorithm : NSObject

#pragma mark - 最大公约数 & 最小公倍数
/**
 辗转相除法（欧几里德法）
 */

/// 两个数的最大公约数
+ (NSUInteger)gcdByEuclideanAlgorithmWithX:(NSUInteger)x andY:(NSUInteger)y;
/// 两个数的最小公倍数
+ (NSUInteger)lcmByEuclideanAlgorithmWithX:(NSUInteger)x andY:(NSUInteger)y;

/// n个数的最大公约数
+ (NSUInteger)gcdArrayByEuclideanAlgorithmWithCount:(NSUInteger)count andValues:(NSUInteger const * const)values;

/// n个数的最小公倍数
+ (NSUInteger)lcmArrayByEuclideanAlgorithmWithCount:(NSUInteger)count andValues:(NSUInteger const * const)values;

/**
 Stein法
 */

/// 两个数的最大公约数
+ (NSUInteger)gcdBySteinWithX:(NSUInteger)x andY:(NSUInteger)y;
/// 两个数的最小公倍数
+ (NSUInteger)lcmBySteinWithX:(NSUInteger)x andY:(NSUInteger)y;

@end

NS_ASSUME_NONNULL_END
