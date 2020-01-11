//
//  NSDictionary+ManipulationAdditions.h
//  GitHubC
//
//  Created by AaronYin on 2019/9/20.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ManipulationAdditions)

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
