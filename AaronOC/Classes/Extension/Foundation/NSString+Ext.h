//
//  NSString+Ext.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Ext)

/**
 Returns a lowercase NSString for md5 hash.
 */
- (nullable NSString *)md5String;

@end

NS_ASSUME_NONNULL_END
