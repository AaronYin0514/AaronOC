//
//  NSMutableArray+Ext.h
//  GitHubC
//
//  Created by AaronYin on 2020/1/5.
//  Copyright © 2020 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Ext)

- (void)safeAddObject:(id)anObject;

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
