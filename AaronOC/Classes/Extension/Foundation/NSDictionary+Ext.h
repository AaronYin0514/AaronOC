//
//  NSDictionary+Ext.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Ext)

// Merges the keys and values from the given dictionary into the receiver. If
// both the receiver and `dictionary` have a given key, the value from
// `dictionary` is used.
//
// Returns a new dictionary containing the entries of the receiver combined with
// those of `dictionary`.
- (NSDictionary *)dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;

// Creates a new dictionary with all the entries for the given keys removed from
// the receiver.
- (NSDictionary *)dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

@end

NS_ASSUME_NONNULL_END
