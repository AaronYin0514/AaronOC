//
//  NSSet+ManipulationAdditions.m
//  GitHubC
//
//  Created by AaronYin on 2019/9/22.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "NSSet+ManipulationAdditions.h"

@implementation NSSet (ManipulationAdditions)

- (NSSet *)setByAddingEntriesFromIndexSet:(NSSet *)set {
    if (set == nil) {
        return self;
    }
    NSMutableSet *result = [self mutableCopy];
    [result unionSet:set];
    return result;
}

@end
