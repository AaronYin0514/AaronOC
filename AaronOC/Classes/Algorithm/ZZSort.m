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
    NSUInteger count = 0;
    NSUInteger exchangeCount = 0;
    NSMutableArray *changeArray = [array mutableCopy];
    for (int i =0; i < changeArray.count; i++) {
        count ++;
        BOOL isFinish = YES;
        for (int j = 0; j < changeArray.count -1; j++) {
            if (change(changeArray[j], changeArray[j+1])) {
                [changeArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                isFinish = NO;
                exchangeCount++;
            }
        }
        if (isFinish) {
            break;
        }
    }
    return changeArray;
}

@end
