//
//  NSDictionary+ManipulationAdditions.m
//  GitHubC
//
//  Created by AaronYin on 2019/9/20.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import "NSDictionary+ManipulationAdditions.h"

@implementation NSDictionary (ManipulationAdditions)

- (NSDictionary *)dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary {
    if (dictionary == nil) {
        return self;
    }
    NSMutableDictionary *result = [self mutableCopy];
    [result addEntriesFromDictionary:dictionary];
    return result;
}

- (NSDictionary *)dictionaryByRemovingEntriesWithKeys:(NSSet *)keys {
    if (keys == nil) {
        return self;
    }
    NSMutableDictionary *result = [self mutableCopy];
    [result removeObjectsForKeys:keys.allObjects];
    return result;
}

@end
