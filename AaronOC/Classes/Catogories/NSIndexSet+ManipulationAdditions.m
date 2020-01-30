//
//  NSIndexSet+ManipulationAdditions.m
//  GitHubC
//
//  Created by AaronYin on 2019/9/22.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "NSIndexSet+ManipulationAdditions.h"

@implementation NSIndexSet (ManipulationAdditions)

- (NSIndexSet *)indexSetByAddingEntriesFromIndexSet:(NSIndexSet *)indexSet {
    if (indexSet == nil) {
        return self;
    }
    NSMutableIndexSet *result = [self mutableCopy];
    [result addIndexes:indexSet];
    return result;
}

@end
