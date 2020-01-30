//
//  NSObject+JSON.h
//  GitHubC
//
//  Created by AaronYin on 2020/1/7.
//  Copyright © 2020 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JSON)

/// JSON数据转字典
/// @param json NSData，NSString，NSDicrionary
+ (NSDictionary *)dictionaryWithJSON:(id)json;

@end

NS_ASSUME_NONNULL_END
