//
//  NSData+Ext.h
//  AaronOC
//
//  Created by AaronYin on 2020/4/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Ext)

#pragma mark - Hash

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)md5String;

@end

NS_ASSUME_NONNULL_END
