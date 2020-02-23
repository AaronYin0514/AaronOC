//
//  ZZSort.h
//  GitHubC
//
//  Created by AaronYin on 2020/2/23.
//  Copyright © 2020 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    FKSortTypeAsc, /// 生序
    FKSortTypeDesc, /// 降序
} FKSortType;

@interface ZZSort : NSObject

+ (NSArray *)bubbleSortWithArray:(NSArray *)array change:(BOOL(^)(id value1, id value2))change;

@end

NS_ASSUME_NONNULL_END
