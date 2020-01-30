//
//  NSIndexSet+ManipulationAdditions.h
//  GitHubC
//
//  Created by AaronYin on 2019/9/22.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexSet (ManipulationAdditions)

- (NSIndexSet *)indexSetByAddingEntriesFromIndexSet:(NSIndexSet *)indexSet;

@end

NS_ASSUME_NONNULL_END
