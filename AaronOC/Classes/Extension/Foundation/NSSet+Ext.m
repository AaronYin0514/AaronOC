//
//  NSSet+Ext.m
//  AaronOC
//
//  Created by AaronYin on 2020/4/26.
//

#import "NSSet+Ext.h"

@implementation NSSet (Ext)

- (NSSet *)setByAddingEntriesFromIndexSet:(NSSet *)set {
    if (set == nil) {
        return self;
    }
    NSMutableSet *result = [self mutableCopy];
    [result unionSet:set];
    return result;
}

@end
