//
//  NSSet+ManipulationAdditions.h
//  GitHubC
//
//  Created by AaronYin on 2019/9/22.
//  Copyright © 2019 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet (ManipulationAdditions)

- (NSSet *)setByAddingEntriesFromIndexSet:(NSSet *)set;

@end

NS_ASSUME_NONNULL_END
