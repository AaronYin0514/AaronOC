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

/// 冒泡排序
static inline int *bubbleSort(int arr[], int count) {
    int tmp;
    for (int i = 0; i < count-1; i++) {
        for (int j = 0; j < count - 1 - i; j++) {
            if (arr[j] > arr[j+1]) {
                tmp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = tmp;
            }
        }
    }
    return arr;
}

/// 选择排序
static inline int *selectSort(int arr[], int count) {
    int minIndex,tmp;
    for (int i = 0; i < count - 1; i++) {
        minIndex = i;
        for (int j = i + 1; j < count; j++) {
            if (arr[minIndex] > arr[j]) {
                minIndex = j;
            }
        }
        tmp = arr[i];
        arr[i] = arr[minIndex];
        arr[minIndex] = tmp;
    }
    return arr;
}

@interface ZZSort : NSObject

/// 冒泡排序
+ (NSArray *)bubbleSortWithArray:(NSArray *)array change:(BOOL(^)(id value1, id value2))change;

/// 选择排序
+ (NSArray *)selectSortWithArray:(NSArray *)array change:(BOOL(^)(id value1, id value2))change;

@end

NS_ASSUME_NONNULL_END
