//
//  NSDictionary+Ext.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/26.
//

#import "NSDictionary+Ext.h"

@implementation NSDictionary (Ext)

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
