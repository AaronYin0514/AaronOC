//
//  ZZSort.m
//  GitHubC
//
//  Created by AaronYin on 2020/2/23.
//  Copyright © 2020 Aaron. All rights reserved.
//

#import "ZZSort.h"

@implementation ZZSort

+ (NSArray *)bubbleSortWithArray:(NSArray *)array change:(BOOL(^)(id value1, id value2))change {
    if (!change || !array) {
        return nil;
    }
    NSMutableArray *changeArray = [array mutableCopy];
    for (int i = 0; i < changeArray.count; i++) {
        BOOL isFinish = YES;
        for (int j = 0; j < changeArray.count - 1; j++) {
            if (change(changeArray[j], changeArray[j + 1])) {
                [changeArray exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                isFinish = NO;
            }
        }
        if (isFinish) {
            break;
        }
    }
    return changeArray;
}

+ (NSArray *)selectSortWithArray:(NSArray *)array change:(BOOL(^)(id value1, id value2))change {
    if (!change || !array) {
        return nil;
    }
    NSMutableArray *changeArray = [array mutableCopy];
    NSInteger minIndex;
    for (int i = 0; i < changeArray.count - 1; i++) {
        minIndex = i;
        for (int j = i + 1; j < changeArray.count; j++) {
            if (change(changeArray[minIndex], changeArray[j])) {
                minIndex = j;
            }
        }
        if (i != minIndex) {
            [changeArray exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
        }
    }
    return changeArray;
}

@end
