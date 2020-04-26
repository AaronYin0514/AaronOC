//
//  NSIndexSet+Ext.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexSet (Ext)

- (NSIndexSet *)indexSetByAddingEntriesFromIndexSet:(NSIndexSet *)indexSet;

@end

NS_ASSUME_NONNULL_END
