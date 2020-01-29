//
//  NSMutableArray+Ext.m
//  GitHubC
//
//  Created by AaronYin on 2020/1/5.
//  Copyright © 2020 Aaron. All rights reserved.
//

#import "NSMutableArray+Ext.h"

@implementation NSMutableArray (Ext)

- (void)safeAddObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self addObject:anObject];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        return;
    }
    if (index > self.count) {
        return;
    }
    [self insertObject:anObject atIndex:index];
}

@end
