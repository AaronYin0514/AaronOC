//
//  GHAlgorithm.m
//  GitHubC
//
//  Created by AaronYin on 2019/9/5.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "GHAlgorithm.h"

@implementation GHAlgorithm

+ (NSUInteger)gcdByEuclideanAlgorithmWithX:(NSUInteger)x andY:(NSUInteger)y {
    NSUInteger temp;                   //整形零时变量
    if (x < y) {
        //x < y 则交换
        temp = x;
        x= y;
        y = temp;
    }
    //x中大数除以y中小数循环取余，直到b及余数为0
    while(y != 0) {
        temp = x % y;
        x = y;
        y = temp;
    }
    //返回最大公约数到调用函数处
    return x;
}

+ (NSUInteger)lcmByEuclideanAlgorithmWithX:(NSUInteger)x andY:(NSUInteger)y {
    //求出最大公约数
    NSInteger temp = [self gcdByEuclideanAlgorithmWithX:x andY:y];
    //返回最小公倍数到主调函数处进行输出
    return (x * y / temp);
}

+ (NSUInteger)gcdArrayByEuclideanAlgorithmWithCount:(NSUInteger)count andValues:(NSUInteger const * const)values {
    if (count == 0) {
        return 0;
    }
    NSUInteger result = values[0];
    for (size_t i = 1; i < count; ++i) {
        result = [self gcdByEuclideanAlgorithmWithX:values[i] andY:result];
    }
    return result;
}

+ (NSUInteger)lcmArrayByEuclideanAlgorithmWithCount:(NSUInteger)count andValues:(NSUInteger const * const)values {
    NSUInteger gcd = [self gcdArrayByEuclideanAlgorithmWithCount:count andValues:values];
    NSUInteger minMultiple = 1;
    for (NSInteger i = 0; i < count; i++) {
        NSUInteger value = values[i];
        minMultiple = minMultiple * value;
    }
    NSUInteger pow = powl(gcd, count - 1);
    return minMultiple / pow;
}

+ (NSUInteger)gcdBySteinWithX:(NSUInteger)x andY:(NSUInteger)y {
    NSUInteger factor = 0;
    NSUInteger temp;
    if ( x < y ) {
        temp = x;
        x = y;
        y = temp;
    }
    if ( 0 == y ) {
        return 0;
    }
    while ( x != y ) {
        //当x时偶数时
        if ( x & 0x1 ) {
            if ( y & 0x1 ) {
                //当x和y都是偶数时
                y = ( x - y ) >> 1;
                x -= y;
            } else {
                //当x是偶数，y是奇数
                y >>= 1;
            }
        } else {
            //当x是奇数
            if ( y & 0x1 ) {
                x >>= 1;
                if ( x < y ) {
                    temp = x;
                    x = y;
                    y = temp;
                }
            } else {
                //当x和y都是奇数
                x >>= 1;
                y >>= 1;
                ++factor;
            }
        }
    }
    return ( x << factor );
}

+ (NSUInteger)lcmBySteinWithX:(NSUInteger)x andY:(NSUInteger)y {
    NSUInteger temp = [self gcdBySteinWithX:x andY:y];
    return (x * y / temp);
}

@end
