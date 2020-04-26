//
//  NSIndexSet+Ext.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/26.
//

#import "NSIndexSet+Ext.h"

@implementation NSIndexSet (Ext)

- (NSIndexSet *)indexSetByAddingEntriesFromIndexSet:(NSIndexSet *)indexSet {
    if (indexSet == nil) {
        return self;
    }
    NSMutableIndexSet *result = [self mutableCopy];
    [result addIndexes:indexSet];
    return result;
}

@end
